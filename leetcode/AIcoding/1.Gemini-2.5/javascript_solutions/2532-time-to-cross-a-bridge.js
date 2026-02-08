var findCrossingTime = function(n, k, time) {
    // Min-heap implementation
    class MinHeap {
        constructor(comparator = (a, b) => a[0] - b[0]) {
            this.heap = [];
            this.comparator = comparator;
        }

        size() {
            return this.heap.length;
        }

        peek() {
            return this.heap[0];
        }

        push(item) {
            this.heap.push(item);
            this._bubbleUp(this.heap.length - 1);
        }

        pop() {
            if (this.heap.length === 0) return undefined;
            if (this.heap.length === 1) return this.heap.pop();

            const root = this.heap[0];
            this.heap[0] = this.heap.pop();
            this._bubbleDown(0);
            return root;
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

        _bubbleDown(index) {
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

    let currentTime = 0;
    let totalCrossed = 0; // Number of people who have made their final L->R crossing and are 'done'

    // People waiting on the left bank (to cross L->R)
    // Priority: [time_L_R, person_id] - smaller time, then smaller id
    const waitLeft = new MinHeap((a, b) => {
        if (a[0] !== b[0]) return a[0] - b[0];
        return a[1] - b[1];
    });

    // People waiting on the right bank (to cross R->L)
    // Priority: [time_R_L, person_id] - smaller time, then smaller id
    const waitRight = new MinHeap((a, b) => {
        if (a[0] !== b[0]) return a[0] - b[0];
        return a[1] - b[1];
    });

    // People currently crossing from left to right
    // Priority: [finish_time, person_id] - smaller finish_time
    const bridgeLeft = new MinHeap();

    // People currently crossing from right to left
    // Priority: [finish_time, person_id] - smaller finish_time
    const bridgeRight = new MinHeap();

    // Initially, all n people are on the left bank, ready to cross
    // Store [time_L_R, time_R_L, person_id] for convenience
    for (let i = 0; i < n; i++) {
        waitLeft.push([time[i][0], time[i][1], i]);
    }

    let lastPersonFinishTime = 0;

    while (totalCrossed < n) {
        // 1. Move people off the bridge who have finished crossing by `currentTime`
        // People finishing L->R crossing
        while (bridgeLeft.size() > 0 && bridgeLeft.peek()[0] <= currentTime) {
            const [finishTime, personId] = bridgeLeft.pop();
            // This person is now on the right bank.
            // If there are still people on the left bank to be picked up, this person returns.
            // Otherwise, this person is one of the final 'n' people who stay on the right.
            if (totalCrossed < n - k) { // If we still need to ferry people
                waitRight.push([time[personId][1], personId]); // Add to right bank waiting to return
            } else { // This person is one of the last 'k' people, they stay on the right
                totalCrossed++;
                lastPersonFinishTime = Math.max(lastPersonFinishTime, finishTime);
            }
        }

        // People finishing R->L crossing
        while (bridgeRight.size() > 0 && bridgeRight.peek()[0] <= currentTime) {
            const [finishTime, personId] = bridgeRight.pop();
            waitLeft.push([time[personId][0], time[personId][1], personId]); // Add to left bank waiting to cross
        }

        // 2. Decide who crosses next (prioritize R->L if possible)
        let moved = false;

        // Try to send people from Right to Left (returning)
        // Only return if there are people still on the left bank to be picked up
        if (waitRight.size() > 0 && bridgeRight.size() < k && totalCrossed < n) {
            const [returnTime, personId] = waitRight.pop();
            bridgeRight.push([currentTime + returnTime, personId]);
            moved = true;
        }
        // Else, try to send people from Left to Right (crossing)
        else if (waitLeft.size() > 0 && bridgeLeft.size() < k) {
            const [crossTime, returnTime, personId] = waitLeft.pop();
            bridgeLeft.push([currentTime + crossTime, personId]);
            moved = true;
        }

        // 3. If no one could move, advance `currentTime` to the next event
        if (!moved) {
            // If no one is on the bridge, and no one is waiting, then all 'n' people must have crossed.
            // This state should only be reached if totalCrossed == n, which is handled by the while condition.
            // If totalCrossed < n, then there must be people on the bridge or waiting.
            if (bridgeLeft.size() === 0 && bridgeRight.size() === 0) {
                // This means no one can move, and no one is on the bridge.
                // This state implies a deadlock or all people already crossed.
                // Since totalCrossed < n, it means people are stuck.
                // This case should not be reached if the logic is correct and a solution exists.
                // For safety, we can break or throw an error.
                // In context of LeetCode, it means the current `currentTime` is the answer.
                break; 
            }

            let nextFinishTime = Infinity;
            if (bridgeLeft.size() > 0) {
                nextFinishTime = Math.min(nextFinishTime, bridgeLeft.peek()[0]);
            }
            if (bridgeRight.size() > 0) {
                nextFinishTime = Math.min(nextFinishTime, bridgeRight.peek()[0]);
            }
            currentTime = Math.max(currentTime, nextFinishTime);
        }
    }

    // After the loop, `totalCrossed` is `n`. The answer is `lastPersonFinishTime`.
    // The `currentTime` might be later than the last person actually finishing if there was idle time.
    // So we need to track the max finish time.
    return lastPersonFinishTime;
};