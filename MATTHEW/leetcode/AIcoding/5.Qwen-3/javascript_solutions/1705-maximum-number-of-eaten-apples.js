function maxEatenApple(apples, days) {
    let n = apples.length;
    let heap = [];
    let time = 0;
    let count = 0;

    while (time < n || heap.length > 0) {
        if (time < n && apples[time] > 0) {
            let expire = time + days[time];
            heap.push([expire, apples[time]]);
            heap.sort((a, b) => a[0] - b[0]);
        }

        while (heap.length > 0 && heap[0][0] <= time) {
            heap.shift();
        }

        if (heap.length > 0) {
            count++;
            heap[0][1]--;
            if (heap[0][1] === 0) {
                heap.shift();
            }
        }

        time++;
    }

    return count;
}