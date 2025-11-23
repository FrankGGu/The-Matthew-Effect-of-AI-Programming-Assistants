var maximumSum = function(nums) {
    const digitSum = (num) => {
        let sum = 0;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }
        return sum;
    };

    const map = new Map();
    let maxSum = -1;

    for (const num of nums) {
        const sum = digitSum(num);
        if (map.has(sum)) {
            const prevNum = map.get(sum);
            maxSum = Math.max(maxSum, prevNum + num);
            if (num > prevNum) {
                map.set(sum, num);
            }
        } else {
            map.set(sum, num);
        }
    }

    return maxSum;
};