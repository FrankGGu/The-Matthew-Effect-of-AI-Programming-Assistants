var eatenApples = function(apples, days) {
    let n = apples.length;
    let eaten = 0;
    let pq = [];
    let i = 0;

    while (i < n || pq.length > 0) {
        while (pq.length > 0 && pq[0][0] <= i) {
            pq.shift();
        }

        if (i < n && apples[i] > 0) {
            pq.push([i + days[i], apples[i]]);
            pq.sort((a, b) => a[0] - b[0]);
        }

        if (pq.length > 0) {
            pq[0][1]--;
            eaten++;
            if (pq[0][1] === 0) {
                pq.shift();
            }
        }

        i++;
    }

    return eaten;
};