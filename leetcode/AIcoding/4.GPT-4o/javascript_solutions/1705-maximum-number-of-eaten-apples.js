var eatenApples = function(apples, days) {
    let maxHeap = new MaxPriorityQueue();
    let count = 0;

    for (let day = 0; day < days; day++) {
        if (apples[day] > 0) {
            maxHeap.enqueue(apples[day], apples[day]);
        }

        while (maxHeap.size() > 0 && (maxHeap.front().element <= day)) {
            maxHeap.dequeue();
        }

        if (maxHeap.size() > 0) {
            count++;
            let maxApples = maxHeap.dequeue().element;
            if (maxApples > 1) {
                maxHeap.enqueue(maxApples - 1, maxApples - 1);
            }
        }
    }

    return count;
};