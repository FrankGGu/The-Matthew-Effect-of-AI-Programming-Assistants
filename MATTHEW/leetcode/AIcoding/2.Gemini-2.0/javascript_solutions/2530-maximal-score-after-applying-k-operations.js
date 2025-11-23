var maxScore = function(nums, k) {
    const pq = new MaxPriorityQueue({ priority: x => x });
    for (const num of nums) {
        pq.enqueue(num);
    }

    let score = 0;
    for (let i = 0; i < k; i++) {
        const { element } = pq.dequeue();
        score += element;
        pq.enqueue(Math.ceil(element / 3));
    }

    return score;
};