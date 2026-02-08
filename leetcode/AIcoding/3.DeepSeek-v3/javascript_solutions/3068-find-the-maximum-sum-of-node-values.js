var maximumValueSum = function(nums, k, edges) {
    let totalSum = 0;
    let count = 0;
    let minDiff = Infinity;

    for (let num of nums) {
        let xor = num ^ k;
        if (xor > num) {
            totalSum += xor;
            count++;
            minDiff = Math.min(minDiff, xor - num);
        } else {
            totalSum += num;
            minDiff = Math.min(minDiff, num - xor);
        }
    }

    if (count % 2 === 0) {
        return totalSum;
    } else {
        return totalSum - minDiff;
    }
};