class MaxPriorityQueue {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) {
            return undefined;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const max = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._sinkDown(0);
        return max;
    }

    peek() {
        return this.heap.length > 0 ? this.heap[0] : undefined;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _bubbleUp(index) {
        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] < this.heap[index]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _sinkDown(index) {
        let leftChildIndex, rightChildIndex, largestIndex;
        const length = this.heap.length;

        while (true) {
            leftChildIndex = 2 * index + 1;
            rightChildIndex = 2 * index + 2;
            largestIndex = index;

            if (leftChildIndex < length && this.heap[leftChildIndex] > this.heap[largestIndex]) {
                largestIndex = leftChildIndex;
            }

            if (rightChildIndex < length && this.heap[rightChildIndex] > this.heap[largestIndex]) {
                largestIndex = rightChildIndex;
            }

            if (largestIndex !== index) {
                [this.heap[index], this.heap[largestIndex]] = [this.heap[largestIndex], this.heap[index]];
                index = largestIndex;
            } else {
                break;
            }
        }
    }
}

var minRefuelStops = function(target, startFuel, stations) {
    let stops = 0;
    let currentFuel = startFuel;
    let currentPosition = 0;
    const pq = new MaxPriorityQueue();

    const allStops = stations.concat([[target, 0]]);

    for (let i = 0; i < allStops.length; i++) {
        const [stationDistance, stationFuel] = allStops[i];
        const fuelNeeded = stationDistance - currentPosition;

        while (currentFuel < fuelNeeded) {
            if (pq.isEmpty()) {
                return -1;
            }
            currentFuel += pq.pop();
            stops++;
        }

        currentFuel -= fuelNeeded;
        currentPosition = stationDistance;

        if (i < stations.length) {
            pq.push(stationFuel);
        }
    }

    return stops;
};