var countLargestGroup = function(n) {
    const sumCount = {};
    let maxCount = 0;
    let result = 0;

    for (let i = 1; i <= n; i++) {
        let num = i;
        let sum = 0;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }

        if (!sumCount[sum]) {
            sumCount[sum] = 0;
        }
        sumCount[sum]++;

        if (sumCount[sum] > maxCount) {
            maxCount = sumCount[sum];
            result = 1;
        } else if (sumCount[sum] === maxCount) {
            result++;
        }
    }

    return result;
};