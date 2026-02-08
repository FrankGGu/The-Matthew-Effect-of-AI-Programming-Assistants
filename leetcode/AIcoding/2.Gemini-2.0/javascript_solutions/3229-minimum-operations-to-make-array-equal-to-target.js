var minOperations = function(nums, target) {
    let sum = 0;
    let ops = 0;
    let pq = [];

    for (let num of nums) {
        sum += num;
        pq.push(num);
    }

    pq.sort((a, b) => b - a);

    if (sum < target) return -1;

    while (target > 0) {
        let largest = pq.shift();
        if (largest <= target) {
            target -= largest;
        } else {
            if (largest > target) {
                if (largest === target) {
                    target = 0;
                    break;
                }
                pq.unshift(largest / 2);
                pq.unshift(largest / 2);
                pq.sort((a, b) => b - a);
                ops++;
            }
        }
    }

    return ops;
};