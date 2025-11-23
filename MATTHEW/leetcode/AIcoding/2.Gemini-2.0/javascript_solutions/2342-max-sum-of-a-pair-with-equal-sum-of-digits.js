var maxSum = function(nums) {
    const sumMap = new Map();
    let maxSum = -1;

    for (const num of nums) {
        let sum = 0;
        let temp = num;
        while (temp > 0) {
            sum += temp % 10;
            temp = Math.floor(temp / 10);
        }

        if (sumMap.has(sum)) {
            maxSum = Math.max(maxSum, sumMap.get(sum) + num);
            sumMap.set(sum, Math.max(sumMap.get(sum), num));
        } else {
            sumMap.set(sum, num);
        }
    }

    return maxSum;
};