class MovieRentingSystem {
    constructor(n, entries) {
        this.movies = new Map();
        this.rented = new MinHeap((a, b) => {
            if (a[0] !== b[0]) return a[0] - b[0];
            if (a[1] !== b[1]) return a[1] - b[1];
            return a[2] - b[2];
        });
        this.priceMap = new Map();
        for (const [shop, movie, price] of entries) {
            if (!this.movies.has(movie)) {
                this.movies.set(movie, new MinHeap((a, b) => {
                    if (a[0] !== b[0]) return a[0] - b[0];
                    return a[1] - b[1];
                }));
            }
            this.movies.get(movie).push([price, shop]);
            this.priceMap.set(`${shop}-${movie}`, price);
        }
    }

    search(movie) {
        if (!this.movies.has(movie)) return [];
        const heap = this.movies.get(movie);
        const temp = [];
        const result = [];
        while (heap.size() > 0 && result.length < 5) {
            const [price, shop] = heap.pop();
            if (!this.isRented(shop, movie)) {
                result.push(shop);
            }
            temp.push([price, shop]);
        }
        for (const [price, shop] of temp) {
            heap.push([price, shop]);
        }
        return result;
    }

    rent(shop, movie) {
        const price = this.priceMap.get(`${shop}-${movie}`);
        this.rented.push([price, shop, movie]);
    }

    drop(shop, movie) {
        const price = this.priceMap.get(`${shop}-${movie}`);
        const temp = [];
        while (this.rented.size() > 0) {
            const [p, s, m] = this.rented.pop();
            if (s === shop && m === movie) {
                break;
            }
            temp.push([p, s, m]);
        }
        for (const [p, s, m] of temp) {
            this.rented.push([p, s, m]);
        }
    }

    report() {
        const temp = [];
        const result = [];
        while (this.rented.size() > 0 && result.length < 5) {
            const [price, shop, movie] = this.rented.pop();
            result.push([shop, movie]);
            temp.push([price, shop, movie]);
        }
        for (const [price, shop, movie] of temp) {
            this.rented.push([price, shop, movie]);
        }
        return result;
    }

    isRented(shop, movie) {
        const temp = [];
        let found = false;
        while (this.rented.size() > 0) {
            const [price, s, m] = this.rented.pop();
            if (s === shop && m === movie) {
                found = true;
            }
            temp.push([price, s, m]);
        }
        for (const [price, s, m] of temp) {
            this.rented.push([price, s, m]);
        }
        return found;
    }
}

class MinHeap {
    constructor(comparator) {
        this.heap = [];
        this.comparator = comparator || ((a, b) => a - b);
    }

    push(value) {
        this.heap.push(value);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        const min = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.bubbleDown(0);
        }
        return min;
    }

    size() {
        return this.heap.length;
    }

    bubbleUp(index) {
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

    bubbleDown(index) {
        while (true) {
            const leftChildIndex = 2 * index + 1;
            const rightChildIndex = 2 * index + 2;
            let smallestChildIndex = index;
            if (leftChildIndex < this.heap.length && this.comparator(this.heap[leftChildIndex], this.heap[smallestChildIndex]) < 0) {
                smallestChildIndex = leftChildIndex;
            }
            if (rightChildIndex < this.heap.length && this.comparator(this.heap[rightChildIndex], this.heap[smallestChildIndex]) < 0) {
                smallestChildIndex = rightChildIndex;
            }
            if (smallestChildIndex !== index) {
                [this.heap[index], this.heap[smallestChildIndex]] = [this.heap[smallestChildIndex], this.heap[index]];
                index = smallestChildIndex;
            } else {
                break;
            }
        }
    }
}