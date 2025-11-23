function smallestRange(heads) {
    const minHeap = [];
    let maxVal = -Infinity;

    for (let i = 0; i < heads.length; i++) {
        if (heads[i]) {
            minHeap.push([heads[i].val, i, 0]);
            maxVal = Math.max(maxVal, heads[i].val);
        }
    }

    function heapify(arr, i) {
        const left = 2 * i + 1;
        const right = 2 * i + 2;
        let smallest = i;

        if (left < arr.length && arr[left][0] < arr[smallest][0]) {
            smallest = left;
        }

        if (right < arr.length && arr[right][0] < arr[smallest][0]) {
            smallest = right;
        }

        if (smallest !== i) {
            [arr[i], arr[smallest]] = [arr[smallest], arr[i]];
            heapify(arr, smallest);
        }
    }

    for (let i = Math.floor(minHeap.length / 2); i >= 0; i--) {
        heapify(minHeap, i);
    }

    let range = [-Infinity, Infinity];

    while (true) {
        const [currentVal, listIdx, nodeIdx] = minHeap[0];

        if (range[1] - range[0] > maxVal - currentVal) {
            range = [currentVal, maxVal];
        }

        const nextNode = heads[listIdx].next;
        if (!nextNode) break;

        minHeap[0] = [nextNode.val, listIdx, nodeIdx + 1];
        heapify(minHeap, 0);

        maxVal = Math.max(maxVal, nextNode.val);
    }

    return range;
}