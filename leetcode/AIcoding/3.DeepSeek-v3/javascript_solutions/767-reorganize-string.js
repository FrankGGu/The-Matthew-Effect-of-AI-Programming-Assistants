var reorganizeString = function(S) {
    const freq = {};
    for (const char of S) {
        freq[char] = (freq[char] || 0) + 1;
    }

    const maxHeap = new MaxPriorityQueue();
    for (const char in freq) {
        maxHeap.enqueue(char, freq[char]);
    }

    let result = [];
    while (maxHeap.size() > 1) {
        const first = maxHeap.dequeue();
        const second = maxHeap.dequeue();

        result.push(first.element, second.element);

        if (first.priority > 1) {
            maxHeap.enqueue(first.element, first.priority - 1);
        }
        if (second.priority > 1) {
            maxHeap.enqueue(second.element, second.priority - 1);
        }
    }

    if (maxHeap.size() === 1) {
        const last = maxHeap.dequeue();
        if (last.priority > 1) {
            return "";
        }
        result.push(last.element);
    }

    return result.join('');
};