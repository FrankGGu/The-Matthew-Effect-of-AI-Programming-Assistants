class MinPriorityQueue {
    constructor() {
        this.heap = [];
    }

    getParentIndex(i) {
        return Math.floor((i - 1) / 2);
    }

    getLeftChildIndex(i) {
        return 2 * i + 1;
    }

    getRightChildIndex(i) {
        return 2 * i + 2;
    }

    hasParent(i) {
        return this.getParentIndex(i) >= 0;
    }

    hasLeftChild(i) {
        return this.getLeftChildIndex(i) < this.heap.length;
    }

    hasRightChild(i) {
        return this.getRightChildIndex(i) < this.heap.length;
    }

    getParent(i) {
        return this.heap[this.getParentIndex(i)];
    }

    getLeftChild(i) {
        return this.heap[this.getLeftChildIndex(i)];
    }

    getRightChild(i) {
        return this.heap[this.getRightChildIndex(i)];
    }

    swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    peek() {
        if (this.heap.length === 0) {
            return undefined;
        }
        return this.heap[0];
    }

    size() {
        return this.heap.length;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    push(item) {
        this.heap.push(item);
        this.heapifyUp();
    }

    pop() {
        if (this.heap.length === 0) {
            return undefined;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.heapifyDown();
        return item;
    }

    heapifyUp() {
        let index = this.heap.length - 1;
        while (this.hasParent(index) && this.getParent(index) > this.heap[index]) {
            this.swap(this.getParentIndex(index), index);
            index = this.getParentIndex(index);
        }
    }

    heapifyDown() {
        let index = 0;
        while (this.hasLeftChild(index)) {
            let smallerChildIndex = this.getLeftChildIndex(index);
            if (this.hasRightChild(index) && this.getRightChild(index) < this.getLeftChild(index)) {
                smallerChildIndex = this.getRightChildIndex(index);
            }

            if (this.heap[index] < this.heap[smallerChildIndex]) {
                break;
            } else {
                this.swap(index, smallerChildIndex);
            }
            index = smallerChildIndex;
        }
    }
}

var earliestSecondToMarkIndices = function(nums, changeOperations) {
    const n = nums.length;
    const m = changeOperations.length;

    let low = 1;
    let high = 2 * 10**9;
    let ans = -1;

    const check = (k) => {
        const last_op_time = new Array(n).fill(-1);
        for (let i = 0; i < m; i++) {
            const [time, idx] = changeOperations[i];
            if (time <= k) {
                last_op_time[idx] = Math.max(last_op_time[idx], time);
            }
        }

        const eligible_indices_data = [];
        for (let j = 0; j < n; j++) {
            if (last_op_time[j] !== -1) {
                eligible_indices_data.push({val: nums[j], time: last_op_time[j]});
            }
        }

        if (eligible_indices_data.length < n) {
            return false;
        }

        eligible_indices_data.sort((a, b) => b.time - a.time);

        const pq = new MinPriorityQueue();
        let marked_count = 0;
        let change_ops_needed = 0;
        let current_data_idx = 0;

        for (let t = k; t >= 1; t--) {
            while (current_data_idx < eligible_indices_data.length && eligible_indices_data[current_data_idx].time === t) {
                pq.push(eligible_indices_data[current_data_idx].val);
                current_data_idx++;
            }

            if (pq.size() > 0) {
                const val = pq.pop();
                marked_count++;
                if (val > 0) {
                    change_ops_needed++;
                }
            }
        }

        return marked_count === n && change_ops_needed <= n;
    };

    while (low <= high) {
        const mid = Math.floor(low + (high - low) / 2);
        if (check(mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};