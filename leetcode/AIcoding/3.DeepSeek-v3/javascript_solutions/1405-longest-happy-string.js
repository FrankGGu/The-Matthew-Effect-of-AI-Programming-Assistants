var longestDiverseString = function(a, b, c) {
    const maxHeap = new MaxPriorityQueue({ priority: (el) => el.count });
    if (a > 0) maxHeap.enqueue({ char: 'a', count: a });
    if (b > 0) maxHeap.enqueue({ char: 'b', count: b });
    if (c > 0) maxHeap.enqueue({ char: 'c', count: c });

    let result = [];

    while (!maxHeap.isEmpty()) {
        let first = maxHeap.dequeue().element;

        if (result.length >= 2 && 
            result[result.length - 1] === first.char && 
            result[result.length - 2] === first.char) {
            if (maxHeap.isEmpty()) break;

            let second = maxHeap.dequeue().element;
            result.push(second.char);
            second.count--;

            if (second.count > 0) {
                maxHeap.enqueue(second);
            }
            maxHeap.enqueue(first);
        } else {
            result.push(first.char);
            first.count--;

            if (first.count > 0) {
                maxHeap.enqueue(first);
            }
        }
    }

    return result.join('');
};