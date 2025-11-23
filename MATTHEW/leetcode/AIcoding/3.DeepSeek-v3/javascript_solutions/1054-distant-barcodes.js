var rearrangeBarcodes = function(barcodes) {
    const freq = {};
    for (const b of barcodes) {
        freq[b] = (freq[b] || 0) + 1;
    }

    const maxHeap = new MaxPriorityQueue({ priority: (entry) => entry[1] });
    for (const key in freq) {
        maxHeap.enqueue([key, freq[key]]);
    }

    const result = [];
    while (maxHeap.size() > 0) {
        let first = maxHeap.dequeue().element;
        if (result.length === 0 || result[result.length - 1] !== first[0]) {
            result.push(first[0]);
            first[1]--;
            if (first[1] > 0) {
                maxHeap.enqueue(first);
            }
        } else {
            let second = maxHeap.dequeue().element;
            result.push(second[0]);
            second[1]--;
            if (second[1] > 0) {
                maxHeap.enqueue(second);
            }
            maxHeap.enqueue(first);
        }
    }

    return result;
};