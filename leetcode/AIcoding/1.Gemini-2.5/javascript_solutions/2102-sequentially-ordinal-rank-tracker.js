class PriorityQueue {
    constructor(comparator = (a, b) => a - b) {
        this.heap = [];
        this.comparator = comparator;
    }

    size() {
        return this.heap.length;
    }

    isEmpty() {
        return this.size() === 0;
    }

    peek() {
        return this.heap[0];
    }

    push(value) {
        this.heap.push(value);
        this._bubbleUp();
    }

    pop() {
        if (this.isEmpty()) return undefined;
        const root = this.heap[0];
        const last = this.heap.pop();
        if (!this.isEmpty()) {
            this.heap[0] = last;
            this._bubbleDown();
        }
        return root;
    }

    _bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.comparator(this.heap[index], this.heap[parentIndex]) < 0) {
                [this.heap[index], this.heap[parentIndex]] = [this.heap[parentIndex], this.heap[index]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _bubbleDown() {
        let index = 0;
        const lastIndex = this.heap.length - 1;
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex <= lastIndex && this.comparator(this.heap[leftChildIndex], this.heap[smallestIndex]) < 0) {
                smallestIndex = leftChildIndex;
            }

            if (rightChildIndex <= lastIndex && this.comparator(this.heap[rightChildIndex], this.heap[smallestIndex]) < 0) {
                smallestIndex = rightChildIndex;
            }

            if (smallestIndex !== index) {
                [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
                index = smallestIndex;
            } else {
                break;
            }
        }
    }
}

var SORTracker = function() {
    // Custom comparator for cities: higher score is better, if scores are equal, lexicographically smaller name is better.
    // Returns negative if cityA is strictly better than cityB.
    // Returns positive if cityB is strictly better than cityA.
    // Returns 0 if they are equal (shouldn't happen with unique names).
    const compareCities = (cityA, cityB) => {
        if (cityA.score !== cityB.score) {
            return cityB.score - cityA.score; // Higher score first (negative if cityA.score > cityB.score)
        }
        return cityA.name.localeCompare(cityB.name); // Smaller name first (negative if cityA.name < cityB.name)
    };

    // 'topK' heap: stores the 'k_rank' best cities.
    // It is a Max-Heap based on 'compareCities' (i.e., it prioritizes 'worse' elements at the top).
    // Its root will be the 'k_rank'-th best city overall.
    // A MinPriorityQueue with comparator (a,b) => -compareCities(a,b) effectively makes it a Max-Heap for compareCities.
    this.topK = new PriorityQueue((a, b) => -compareCities(a, b)); 

    // 'rest' heap: stores all other cities (worse than the 'k_rank'-th best).
    // It is a Min-Heap based on 'compareCities' (i.e., it prioritizes 'better' elements at the top).
    // Its root will be the '(k_rank + 1)'-th best city overall.
    this.rest = new PriorityQueue(compareCities); 

    this.k_rank = 0; // The current rank being tracked (1-indexed in problem, 0-indexed for internal calculation meaning 0th best is not tracked, 1st best, 2nd best etc.)
};

SORTracker.prototype.add = function(name, score) {
    const newCity = { name, score };

    // If topK is empty, or newCity is better or equal to the current k_rank-th best, add to topK.
    // Otherwise, add to rest.
    // compareCities returns negative if newCity is better.
    // topK.peek() is the k_rank-th best city (worst among the top k_rank).
    if (this.topK.isEmpty() || compareCities(newCity, this.topK.peek()) < 0) {
        this.topK.push(newCity);
    } else {
        this.rest.push(newCity);
    }

    // Balance the heaps:
    // Ensure topK always has 'k_rank' elements (if k_rank > 0).
    // If topK has too many elements, move the worst one to rest.
    if (this.topK.size > this.k_rank) {
        this.rest.push(this.topK.pop());
    }
    // If topK has too few elements (and rest has elements), move the best one from rest to topK.
    // This case usually happens when k_rank increases (in get()), but can also happen if add() put a city into 'rest'
    // that should now be in 'topK' because 'topK' was not full.
    if (this.topK.size < this.k_rank && !this.rest.isEmpty()) {
        this.topK.push(this.rest.pop());
    }
};

SORTracker.prototype.get = function() {
    this.k_rank++; // Increment the rank we are looking for

    // If topK doesn't have enough elements for the new k_rank, pull the best from rest.
    if (this.topK.size < this.k_rank && !this.rest.isEmpty()) {
        this.topK.push(this.rest.pop());
    }

    // The root of topK is the k_rank-th best city.
    return this.topK.peek().name;
};