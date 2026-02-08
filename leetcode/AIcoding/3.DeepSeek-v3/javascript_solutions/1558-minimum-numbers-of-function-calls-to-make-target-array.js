var minOperations = function(nums) {
    let addOps = 0;
    let multOps = 0;

    for (let num of nums) {
        let currentMultOps = 0;
        while (num > 0) {
            if (num % 2 === 1) {
                addOps++;
                num--;
            } else {
                currentMultOps++;
                num /= 2;
            }
        }
        multOps = Math.max(multOps, currentMultOps);
    }

    return addOps + multOps;
};