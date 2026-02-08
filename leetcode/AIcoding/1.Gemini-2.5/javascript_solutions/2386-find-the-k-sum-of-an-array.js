class Solution {
    kthLargestSum(nums, k) {
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
                    return null;
                }
                return this.heap[0];
            }

            insert(item) {
                this.heap.push(item);
                this.heapifyUp();
            }

            extractMin() {
                if (this.heap.length === 0) {
                    return null;
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
                while (this.hasParent(index) && this.getParent(index)[0] > this.heap[index][0]) {
                    this.swap(this.getParentIndex(index), index);
                    index = this.getParentIndex(index);
                }
            }

            heapifyDown() {
                let index = 0;
                while (this.hasLeftChild(index)) {
                    let smallerChildIndex = this.getLeftChildIndex(index);
                    if (this.hasRightChild(index) && this.getRightChild(index)[0] < this.getLeftChild(index)[0]) {
                        smallerChildIndex = this.getRightChildIndex(index);
                    }

                    if (this.heap[index][0] < this.heap[smallerChildIndex][0]) {
                        break;
                    } else {
                        this.swap(index, smallerChildIndex);
                    }
                    index = smallerChildIndex;
                }
            }

            size() {
                return this.heap.length;
            }
        }

        let totalSum = 0;
        const absNums = [];

        for (const num of nums) {
            if (num >= 0) {
                totalSum += num;
                absNums.push(num);
            } else {
                absNums.push(-num);
            }
        }

        absNums.sort((a, b) => a - b);

        const pq = new MinPriorityQueue();
        pq.insert([0, 0]);

        const resultReductionSums = [];

        for (let i = 0; i < k; i++) {
            const [currentReductionSum, idx] = pq.extractMin();
            resultReductionSums.push(currentReductionSum);

            if (idx < absNums.length) {
                pq.insert([currentReductionSum + absNums[idx], idx + 1]);

                if (idx > 0) {
                    pq.insert([currentReductionSum + absNums[idx] - absNums[idx - 1], idx + 1]);
                }
            }
        }

        return totalSum - resultReductionSums[k - 1];
    }
}