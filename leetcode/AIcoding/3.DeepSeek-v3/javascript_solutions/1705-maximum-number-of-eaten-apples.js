var eatenApples = function(apples, days) {
    const n = apples.length;
    let res = 0;
    const heap = new MinPriorityQueue({ priority: (item) => item.expiry });

    for (let i = 0; i < n || !heap.isEmpty(); i++) {
        if (i < n && apples[i] > 0) {
            heap.enqueue({ expiry: i + days[i], count: apples[i] });
        }

        while (!heap.isEmpty() && heap.front().element.expiry <= i) {
            heap.dequeue();
        }

        if (!heap.isEmpty()) {
            const front = heap.front().element;
            front.count--;
            res++;
            if (front.count === 0) {
                heap.dequeue();
            }
        }
    }

    return res;
};