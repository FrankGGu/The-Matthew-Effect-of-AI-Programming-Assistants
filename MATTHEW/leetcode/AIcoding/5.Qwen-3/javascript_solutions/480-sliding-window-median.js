function medianSlidingWindow(nums, k) {
    const result = [];
    const left = new Heap((a, b) => a > b);
    const right = new Heap((a, b) => a < b);

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];

        if (left.size() === 0 || num <= left.peek()) {
            left.push(num);
        } else {
            right.push(num);
        }

        while (left.size() > Math.ceil(k / 2)) {
            right.push(left.pop());
        }

        while (right.size() > Math.floor(k / 2)) {
            left.push(right.pop());
        }

        if (i >= k - 1) {
            if (k % 2 === 0) {
                result.push((left.peek() + right.peek()) / 2);
            } else {
                result.push(left.peek());
            }

            const out = nums[i - k + 1];
            if (out <= left.peek()) {
                left.remove(out);
            } else {
                right.remove(out);
            }

            while (left.size() > Math.ceil(k / 2)) {
                right.push(left.pop());
            }

            while (right.size() > Math.floor(k / 2)) {
                left.push(right.pop());
            }
        }
    }

    return result;
}

class Heap {
    constructor(compare) {
        this.compare = compare;
        this.heap = [];
    }

    push(value) {
        this.heap.push(value);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        const value = this.heap[0];
        const last = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = last;
            this.bubbleDown(0);
        }
        return value;
    }

    peek() {
        return this.heap[0];
    }

    size() {
        return this.heap.length;
    }

    remove(value) {
        const index = this.heap.indexOf(value);
        if (index === -1) return;

        const last = this.heap.pop();
        if (index !== this.heap.length) {
            this.heap[index] = last;
            this.bubbleDown(index);
            this.bubbleUp(index);
        }
    }

    bubbleUp(index) {
        while (index > 0) {
            const parent = Math.floor((index - 1) / 2);
            if (this.compare(this.heap[parent], this.heap[index])) {
                [this.heap[parent], this.heap[index]] = [this.heap[index], this.heap[parent]];
                index = parent;
            } else {
                break;
            }
        }
    }

    bubbleDown(index) {
        const length = this.heap.length;
        const element = this.heap[index];

        while (true) {
            let left = 2 * index + 1;
            let right = 2 * index + 2;
            let swap = null;

            if (left < length && this.compare(this.heap[left], element)) {
                swap = left;
            }

            if (right < length && this.compare(this.heap[right], element)) {
                if (swap === null || this.compare(this.heap[right], this.heap[swap])) {
                    swap = right;
                }
            }

            if (swap === null) break;

            [this.heap[index], this.heap[swap]] = [this.heap[swap], this.heap[index]];
            index = swap;
        }
    }
}