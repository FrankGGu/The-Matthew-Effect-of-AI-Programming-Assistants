var halveArray = function(nums) {
    let sum = 0;
    let pq = new MaxPriorityQueue();
    for (let num of nums) {
        sum += num;
        pq.enqueue(num);
    }

    let ops = 0;
    let halvedSum = 0;

    while (halvedSum < sum / 2) {
        let max = pq.dequeue().element;
        halvedSum += max / 2;
        pq.enqueue(max / 2);
        ops++;
    }

    return ops;
};