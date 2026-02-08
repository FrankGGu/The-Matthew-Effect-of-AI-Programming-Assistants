var isPossible = function(target) {
    let sum = 0;
    let pq = new MaxPriorityQueue({ priority: x => x });
    for (let num of target) {
        sum += num;
        pq.enqueue(num);
    }

    while (true) {
        let largest = pq.dequeue().element;
        let restSum = sum - largest;

        if (largest === 1 || restSum === 1) return true;
        if (largest <= restSum || restSum === 0) return false;

        let prev = largest % restSum;
        if (prev === 0) return false;

        pq.enqueue(prev);
        sum = restSum + prev;
    }
};