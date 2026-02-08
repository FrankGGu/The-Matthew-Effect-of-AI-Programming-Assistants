var minCost = function(startX, startY, endX, endY, specialRoads) {
    const manhattanDist = (p1, p2) => Math.abs(p1[0] - p2[0]) + Math.abs(p1[1] - p2[1]);

    const allPointsMap = new Map();
    const addPoint = (x, y) => {
        const pStr = `${x},${y}`;
        if (!allPointsMap.has(pStr)) {
            allPointsMap.set(pStr, [x, y]);
        }
    };

    addPoint(startX, startY);
    addPoint(endX, endY);
    for (const [x1, y1, x2, y2, cost] of specialRoads) {
        addPoint(x1, y1);
        addPoint(x2, y2);
    }

    const startPointStr = `${startX},${startY}`;
    const endPointStr = `${endX},${endY}`;

    const dist = new Map();
    for (const pStr of allPointsMap.keys()) {
        dist.set(pStr, Infinity);
    }
    dist.set(startPointStr, 0);

    class MinHeap {
        constructor() {
            this.heap = [];
        }

        push(item) {
            this.heap.push(item);
            this._bubbleUp(this.heap.length - 1);
        }

        pop() {
            if (this.isEmpty()) {
                return null;
            }
            if (this.heap.length === 1) {
                return this.heap.pop();
            }
            const root = this.heap[0];
            this.heap[0] = this.heap.pop();
            this._bubbleDown(0);
            return root;
        }

        isEmpty() {
            return this.heap.length === 0;
        }

        _bubbleUp(index) {
            while (index > 0) {
                const parentIndex = Math.floor((index - 1) / 2);
                if (this.heap[parentIndex][0] > this.heap[index][0]) {
                    [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                    index = parentIndex;
                } else {
                    break;
                }
            }
        }

        _bubbleDown(index) {
            const lastIndex = this.heap.length - 1;
            while (true) {
                const leftChildIndex = 2 * index + 1;
                const rightChildIndex = 2 * index + 2;
                let smallestIndex = index;

                if (leftChildIndex <= lastIndex && this.heap[leftChildIndex][0] < this.heap[smallestIndex][0]) {
                    smallestIndex = leftChildIndex;
                }

                if (rightChildIndex <= lastIndex && this.heap[rightChildIndex][0] < this.heap[smallestIndex][0]) {
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

    const minHeap = new MinHeap();
    minHeap.push([0, startPointStr]);

    while (!minHeap.isEmpty()) {
        const [currentCost, currentPointStr] = minHeap.pop();

        if (currentCost > dist.get(currentPointStr)) {
            continue;
        }

        if (currentPointStr === endPointStr) {
            return currentCost;
        }

        const currentPointCoords = allPointsMap.get(currentPointStr);

        for (const nextPointStr of allPointsMap.keys()) {
            const nextPointCoords = allPointsMap.get(nextPointStr);
            const travelCost = manhattanDist(currentPointCoords, nextPointCoords);

            if (currentCost + travelCost < dist.get(nextPointStr)) {
                dist.set(nextPointStr, currentCost + travelCost);
                minHeap.push([dist.get(nextPointStr), nextPointStr]);
            }
        }

        for (const [x1, y1, x2, y2, roadCost] of specialRoads) {
            const roadStartStr = `${x1},${y1}`;
            const roadEndStr = `${x2},${y2}`;

            if (currentPointStr === roadStartStr) {
                if (currentCost + roadCost < dist.get(roadEndStr)) {
                    dist.set(roadEndStr, currentCost + roadCost);
                    minHeap.push([dist.get(roadEndStr), roadEndStr]);
                }
            }
        }
    }

    return dist.get(endPointStr);
};