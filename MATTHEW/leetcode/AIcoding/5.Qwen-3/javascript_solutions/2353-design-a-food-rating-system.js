class FoodRatings {
    constructor() {
        this.foodMap = new Map();
        this.cuisineMap = new Map();
    }

    changeRating(food, newRating) {
        const foodInfo = this.foodMap.get(food);
        foodInfo.rating = newRating;
        const cuisine = foodInfo.cuisine;
        const heap = this.cuisineMap.get(cuisine);
        heap.update(heap.findIndex(f => f.food === food), { food, rating: newRating });
    }

    highestRated(cuisine) {
        const heap = this.cuisineMap.get(cuisine);
        return heap[0].food;
    }

    addFood(food, cuisine, rating) {
        if (!this.foodMap.has(food)) {
            this.foodMap.set(food, { cuisine, rating });
            if (!this.cuisineMap.has(cuisine)) {
                this.cuisineMap.set(cuisine, new Heap((a, b) => {
                    if (a.rating !== b.rating) return b.rating - a.rating;
                    return a.food.localeCompare(b.food);
                }));
            }
            const heap = this.cuisineMap.get(cuisine);
            heap.push({ food, rating });
        }
    }
}

class Heap {
    constructor(comparator) {
        this.heap = [];
        this.comparator = comparator;
    }

    push(value) {
        this.heap.push(value);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        const min = this.heap[0];
        const last = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = last;
            this.bubbleDown(0);
        }
        return min;
    }

    peek() {
        return this.heap[0];
    }

    size() {
        return this.heap.length;
    }

    update(index, newValue) {
        this.heap[index] = newValue;
        this.bubbleUp(index);
        this.bubbleDown(index);
    }

    bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.comparator(this.heap[index], this.heap[parentIndex]) >= 0) break;
            [this.heap[index], this.heap[parentIndex]] = [this.heap[parentIndex], this.heap[index]];
            index = parentIndex;
        }
    }

    bubbleDown(index) {
        const length = this.heap.length;
        const element = this.heap[index];
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let swapIndex = null;

            if (leftChildIndex < length) {
                if (this.comparator(this.heap[leftChildIndex], element) < 0) {
                    swapIndex = leftChildIndex;
                }
            }

            if (rightChildIndex < length) {
                if (this.comparator(this.heap[rightChildIndex], element) < 0) {
                    if (swapIndex === null || this.comparator(this.heap[rightChildIndex], this.heap[swapIndex]) < 0) {
                        swapIndex = rightChildIndex;
                    }
                }
            }

            if (swapIndex === null) break;

            [this.heap[index], this.heap[swapIndex]] = [this.heap[swapIndex], this.heap[index]];
            index = swapIndex;
        }
    }
}