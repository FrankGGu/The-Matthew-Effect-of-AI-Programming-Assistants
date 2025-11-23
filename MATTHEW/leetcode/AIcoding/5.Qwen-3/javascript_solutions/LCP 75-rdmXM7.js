function findTheWinner(nums, k) {
    let queue = nums.slice();
    while (queue.length > 1) {
        for (let i = 0; i < k - 1; i++) {
            queue.push(queue.shift());
        }
        queue.shift();
    }
    return queue[0];
}