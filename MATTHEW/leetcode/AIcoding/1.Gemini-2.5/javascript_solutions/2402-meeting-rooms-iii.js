class MinHeap {
    constructor(comparator = (a, b) => a - b) {
        this.heap = [];
        this.comparator = comparator;
    }

    size() {
        return this.heap.length;
    }

    isEmpty() {
        return this.size() === 0;
    }

    peek() {
        return this.heap[0];
    }

    push(value) {
        this.heap.push(value);
        this._bubbleUp();
    }

    pop() {
        if (this.isEmpty()) return undefined;
        const root = this.heap[0];
        const last = this.heap.pop();
        if (!this.isEmpty()) {
            this.heap[0] = last;
            this._bubbleDown();
        }
        return root;
    }

    _bubbleUp() {
        let index = this.heap.length - 1;
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

    _bubbleDown() {
        let index = 0;
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

var mostBooked = function(n, meetings) {
    meetings.sort((a, b) => a[0] - b[0]);

    const availableRooms = new MinHeap((a, b) => a - b);
    for (let i = 0; i < n; i++) {
        availableRooms.push(i);
    }

    const busyRooms = new MinHeap((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    const meetingCounts = new Array(n).fill(0);

    for (const [start, end] of meetings) {
        while (!busyRooms.isEmpty() && busyRooms.peek()[0] <= start) {
            const [_, roomIndex] = busyRooms.pop();
            availableRooms.push(roomIndex);
        }

        let assignedRoomIndex;
        let actualEndTime;

        if (!availableRooms.isEmpty()) {
            assignedRoomIndex = availableRooms.pop();
            actualEndTime = end;
        } else {
            const [prevEndTime, roomIndex] = busyRooms.pop();
            assignedRoomIndex = roomIndex;
            actualEndTime = prevEndTime + (end - start);
        }

        meetingCounts[assignedRoomIndex]++;
        busyRooms.push([actualEndTime, assignedRoomIndex]);
    }

    let maxMeetings = -1;
    let resultRoom = -1;

    for (let i = 0; i < n; i++) {
        if (meetingCounts[i] > maxMeetings) {
            maxMeetings = meetingCounts[i];
            resultRoom = i;
        }
    }

    return resultRoom;
};