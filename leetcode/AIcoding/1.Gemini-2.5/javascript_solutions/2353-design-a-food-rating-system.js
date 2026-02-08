class MaxPriorityQueue {
    constructor() {
        this.heap = [];
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    _getParentIndex(i) {
        return Math.floor((i - 1) / 2);
    }

    _getLeftChildIndex(i) {
        return 2 * i + 1;
    }

    _getRightChildIndex(i) {
        return 2 * i + 2;
    }

    // Returns true if a has higher priority than b
    _compare(a, b) {
        // Higher rating has higher priority
        if (a[0] !== b[0]) {
            return a[0] > b[0];
        }
        // If ratings are equal, smaller foodName has higher priority
        return a[1] < b[1];
    }

    _heapifyUp(index) {
        let parentIndex = this._getParentIndex(index);
        while (index > 0 && this._compare(this.heap[index], this.heap[parentIndex])) {
            this._swap(index, parentIndex);
            index = parentIndex;
            parentIndex = this._getParentIndex(index);
        }
    }

    _heapifyDown(index) {
        let leftChildIndex = this._getLeftChildIndex(index);
        let rightChildIndex = this._getRightChildIndex(index);
        let highestPriorityIndex = index;

        if (leftChildIndex < this.heap.length && this._compare(this.heap[leftChildIndex], this.heap[highestPriorityIndex])) {
            highestPriorityIndex = leftChildIndex;
        }

        if (rightChildIndex < this.heap.length && this._compare(this.heap[rightChildIndex], this.heap[highestPriorityIndex])) {
            highestPriorityIndex = rightChildIndex;
        }

        if (highestPriorityIndex !== index) {
            this._swap(index, highestPriorityIndex);
            this._heapifyDown(highestPriorityIndex);
        }
    }

    enqueue(element) {
        this.heap.push(element);
        this._heapifyUp(this.heap.length - 1);
    }

    dequeue() {
        if (this.heap.length === 0) {
            return undefined;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }

        const highest = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown(0);
        return highest;
    }

    peek() {
        if (this.heap.length === 0) {
            return undefined;
        }
        return { element: this.heap[0] };
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    size() {
        return this.heap.length;
    }
}

class FoodRatings {
    constructor(foods, cuisines, ratings) {
        this.foodInfo = new Map(); // Map<foodName, { cuisine: string, rating: number }>
        this.cuisinePQs = new Map(); // Map<cuisineName, MaxPriorityQueue<[rating, foodName]>>

        for (let i = 0; i < foods.length; i++) {
            const food = foods[i];
            const cuisine = cuisines[i];
            const rating = ratings[i];

            this.foodInfo.set(food, { cuisine, rating });

            if (!this.cuisinePQs.has(cuisine)) {
                this.cuisinePQs.set(cuisine, new MaxPriorityQueue());
            }
            this.cuisinePQs.get(cuisine).enqueue([rating, food]);
        }
    }

    changeRating(food, newRating) {
        const foodData = this.foodInfo.get(food);
        foodData.rating = newRating; // Update the current rating

        // Add the new rating to the priority queue. The old entry will be lazily removed.
        this.cuisinePQs.get(foodData.cuisine).enqueue([newRating, food]);
    }

    highestRated(cuisine) {
        const pq = this.cuisinePQs.get(cuisine);

        while (true) {
            const [rating, food] = pq.peek().element;
            const currentFoodData = this.foodInfo.get(food);

            // If the rating in the PQ matches the current rating for the food, it's valid.
            if (currentFoodData.rating === rating) {
                return food;
            }
            // Otherwise, it's a stale entry, remove it and check the next highest.
            pq.dequeue();
        }
    }
}