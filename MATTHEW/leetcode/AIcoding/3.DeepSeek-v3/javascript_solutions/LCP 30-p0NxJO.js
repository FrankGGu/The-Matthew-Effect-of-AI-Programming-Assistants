var magicTower = function(nums) {
    let hp = 1;
    let sum = 0;
    for (const num of nums) {
        sum += num;
    }
    if (sum < 0) return -1;

    let queue = new MinPriorityQueue();
    let res = 0;
    let current = 0;

    for (const num of nums) {
        current += num;
        if (num < 0) {
            queue.enqueue(num);
        }
        if (current < 0) {
            let min = queue.dequeue().element;
            current -= min;
            res++;
        }
    }
    return res;
};