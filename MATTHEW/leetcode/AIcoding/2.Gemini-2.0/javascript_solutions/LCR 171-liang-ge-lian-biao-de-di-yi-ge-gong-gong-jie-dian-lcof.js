var getTriggerTime = function(nums, k) {
    const n = nums.length;
    const ans = new Array(n).fill(-1);
    const pq = new PriorityQueue({ priority: (x) => -x[0] });
    let i = 0;
    let sum = 0;
    let time = 0;
    while (pq.size() > 0 || i < n) {
        while (i < n && nums[i][0] <= sum) {
            pq.enqueue([nums[i][1], i]);
            i++;
        }
        if (pq.size() > 0) {
            const [val, idx] = pq.dequeue().element;
            sum += val;
            ans[idx] = time + 1;
        }
        time++;
    }
    return ans;
};

class PriorityQueue {
    constructor({ priority }) {
        this.heap = [];
        this.priority = priority;
    }

    enqueue(element) {
        this.heap.push(element);
        this.bubbleUp(this.heap.length - 1);
    }

    dequeue() {
        if (this.isEmpty()) {
            return null;
        }

        if (this.heap.length === 1) {
            return { element: this.heap.pop() };
        }

        const max = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.sinkDown(0);

        return { element: max };
    }

    peek() {
        if (this.isEmpty()) {
            return null;
        }

        return this.heap[0];
    }

    size() {
        return this.heap.length;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.priority(this.heap[index]) <= this.priority(this.heap[parentIndex])) {
                break;
            }
            this.swap(index, parentIndex);
            index = parentIndex;
        }
    }

    sinkDown(index) {
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let largest = index;

            if (leftChildIndex < this.heap.length && this.priority(this.heap[leftChildIndex]) > this.priority(this.heap[largest])) {
                largest = leftChildIndex;
            }

            if (rightChildIndex < this.heap.length && this.priority(this.heap[rightChildIndex]) > this.priority(this.heap[largest])) {
                largest = rightChildIndex;
            }

            if (largest === index) {
                break;
            }

            this.swap(index, largest);
            index = largest;
        }
    }

    swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }
}