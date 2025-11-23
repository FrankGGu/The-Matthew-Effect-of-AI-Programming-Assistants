impl Solution {
    pub fn min_stone_sum(piles: Vec<i32>, k: i32) -> i32 {
        let mut max_heap = std::collections::BinaryHeap::new();
        for &pile in &piles {
            max_heap.push(pile);
        }

        let mut total = piles.iter().sum::<i32>();

        for _ in 0..k {
            if let Some(max_pile) = max_heap.pop() {
                let reduced_pile = max_pile - max_pile / 2;
                total -= max_pile / 2;
                max_heap.push(reduced_pile);
            }
        }

        total
    }
}