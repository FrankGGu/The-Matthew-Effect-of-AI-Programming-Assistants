use std::collections::BinaryHeap;
use std::cmp::Reverse;

#[derive(Eq, PartialEq, Clone)]
struct Location {
    score: i32,
    name: String,
}

impl Ord for Location {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        // Custom comparison for Location:
        // 1. Sort by score in descending order (higher score is better).
        //    If self.score is greater, it should come first (Ordering::Less).
        //    `other.score.cmp(&self.score)` achieves this.
        // 2. If scores are equal, sort by name in ascending order (lexicographically smaller name is better).
        //    If self.name is smaller, it should come first (Ordering::Less).
        //    `self.name.cmp(&other.name)` achieves this.
        other.score.cmp(&self.score)
            .then_with(|| self.name.cmp(&other.name))
    }
}

impl PartialOrd for Location {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

struct SORTracker {
    // `best_k_heap`: This heap will store the `k` best locations.
    // We want its `peek()` to be the `k`-th best location.
    // Since `Location`'s `Ord` makes "better" locations `Ordering::Less`,
    // `Reverse<Location>` makes "better" locations `Ordering::Greater`.
    // So, `BinaryHeap<Reverse<Location>>` acts as a max-heap where `peek()` is the "worst" among its elements.
    // If this heap contains the `k` best elements, its `peek()` will be the `k`-th best.
    best_k_heap: BinaryHeap<Reverse<Location>>,

    // `rest_heap`: This heap will store all locations that are worse than the `k`-th best.
    // We want to efficiently get the best among these "rest" locations.
    // `BinaryHeap<Location>` acts as a min-heap where `peek()` is the "best" (smallest) element.
    rest_heap: BinaryHeap<Location>,

    // `get_count`: Tracks the number of times `get()` has been called, which is `k`.
    get_count: usize,
}

impl SORTracker {
    fn new() -> Self {
        SORTracker {
            best_k_heap: BinaryHeap::new(),
            rest_heap: BinaryHeap::new(),
            get_count: 0,
        }
    }

    fn add(&mut self, name: String, score: i32) {
        let new_loc = Location { score, name };

        // Always add the new location to `best_k_heap` first.
        // `best_k_heap` is a max-heap (due to `Reverse<Location>`), so `Reverse(new_loc)` is pushed.
        self.best_k_heap.push(Reverse(new_loc));

        // After pushing, `best_k_heap` might temporarily contain `(total_added + 1)` elements.
        // To maintain the invariant that `best_k_heap` contains the `k` best elements,
        // we move the "worst" element from `best_k_heap` to `rest_heap`.
        // The `pop()` operation on `best_k_heap` (a max-heap) extracts the "greatest" `Reverse<Location>`,
        // which corresponds to the "worst" `Location` according to `Location`'s `Ord`.
        // This "worst" element is precisely the `k`-th best element if `best_k_heap` had `k` elements.
        let moved_loc = self.best_k_heap.pop().unwrap().0; // `.0` unwraps `Reverse`
        self.rest_heap.push(moved_loc);
    }

    fn get(&mut self) -> String {
        // Increment `k` for the current `get()` call.
        self.get_count += 1;

        // If `best_k_heap` has fewer than `k` elements, it means `k` has increased,
        // and we need to promote the best location from `rest_heap` to `best_k_heap`.
        if self.best_k_heap.len() < self.get_count {
            // `rest_heap` is a min-heap of `Location`, so `pop()` extracts the "best" (smallest) element.
            let promoted_loc = self.rest_heap.pop().unwrap();
            self.best_k_heap.push(Reverse(promoted_loc));
        }

        // After balancing, `best_k_heap` contains the `k` best locations.
        // Its `peek()` (which is a `Reverse<Location>`) represents the `k`-th best location.
        // We unwrap `Reverse` and clone the name.
        self.best_k_heap.peek().unwrap().0.name.clone()
    }
}