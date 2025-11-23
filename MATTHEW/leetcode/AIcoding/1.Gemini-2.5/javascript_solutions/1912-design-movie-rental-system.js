class MinPriorityQueue {
    constructor(comparator) {
        this.heap = [];
        this.comparator = comparator || ((a, b) => {
            for (let i = 0; i < a.length; i++) {
                if (a[i] !== b[i]) {
                    return a[i] - b[i];
                }
            }
            return 0;
        });
    }

    push(item) {
        this.heap.push(item);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) {
            return undefined;
        }
        const min = this.heap[0];
        const last = this.heap.pop();
        if (!this.isEmpty()) {
            this.heap[0] = last;
            this._sinkDown(0);
        }
        return min;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    size() {
        return this.heap.length;
    }

    _bubbleUp(index) {
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

    _sinkDown(index) {
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

class MovieRentalSystem {
    constructor(n, entries) {
        this.shopMoviePrices = new Map(); // Map<shop_id, Map<movie_id, price>>
        this.availableMovies = new Map(); // Map<movie_id, MinPriorityQueue<[price, shop_id]>>
        this.rentedMovies = new MinPriorityQueue(); // MinPriorityQueue<[price, shop_id, movie_id]>
        this.isRented = new Set(); // Set<string> (key: "shop_id-movie_id")

        for (const [shop_id, movie_id, price] of entries) {
            if (!this.shopMoviePrices.has(shop_id)) {
                this.shopMoviePrices.set(shop_id, new Map());
            }
            this.shopMoviePrices.get(shop_id).set(movie_id, price);

            if (!this.availableMovies.has(movie_id)) {
                this.availableMovies.set(movie_id, new MinPriorityQueue());
            }
            this.availableMovies.get(movie_id).push([price, shop_id]);
        }
    }

    search(movie_id) {
        const pq = this.availableMovies.get(movie_id);
        if (!pq) {
            return [];
        }

        const results = [];
        const temp = [];

        while (results.length < 5 && !pq.isEmpty()) {
            const [price, shop_id] = pq.pop();
            const key = `${shop_id}-${movie_id}`;

            if (!this.isRented.has(key)) {
                results.push(shop_id);
                temp.push([price, shop_id]);
            }
        }

        for (const item of temp) {
            pq.push(item);
        }

        return results;
    }

    rent(shop_id, movie_id) {
        const price = this.shopMoviePrices.get(shop_id).get(movie_id);
        const key = `${shop_id}-${movie_id}`;

        if (!this.isRented.has(key)) {
            this.isRented.add(key);
            this.rentedMovies.push([price, shop_id, movie_id]);
        }
    }

    drop(shop_id, movie_id) {
        const price = this.shopMoviePrices.get(shop_id).get(movie_id);
        const key = `${shop_id}-${movie_id}`;

        if (this.isRented.has(key)) {
            this.isRented.delete(key);
            if (!this.availableMovies.has(movie_id)) {
                this.availableMovies.set(movie_id, new MinPriorityQueue());
            }
            this.availableMovies.get(movie_id).push([price, shop_id]);
        }
    }

    report() {
        const results = [];
        const temp = [];

        while (results.length < 5 && !this.rentedMovies.isEmpty()) {
            const [price, shop_id, movie_id] = this.rentedMovies.pop();
            const key = `${shop_id}-${movie_id}`;

            if (this.isRented.has(key)) {
                results.push([shop_id, movie_id]);
                temp.push([price, shop_id, movie_id]);
            }
        }

        for (const item of temp) {
            this.rentedMovies.push(item);
        }

        return results;
    }
}