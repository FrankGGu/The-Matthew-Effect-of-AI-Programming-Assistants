var maxSum = function(nums) {
    const maxDigitMap = new Array(10).fill(0).map(() => []);

    function getMaxDigit(num) {
        let maxD = 0;
        let tempNum = num;
        if (tempNum === 0) return 0; // Handle the case for number 0
        while (tempNum > 0) {
            maxD = Math.max(maxD, tempNum % 10);
            tempNum = Math.floor(tempNum / 10);
        }
        return maxD;
    }

    for (const num of nums) {
        const maxD = getMaxDigit(num);
        maxDigitMap[maxD].push(num);
    }

    let maxSum = -1;

    for (let i = 0; i < 10; i++) {
        const list = maxDigitMap[i];
        if (list.length >= 2) {
            list.sort((a, b) => b - a); // Sort in descending order
            maxSum = Math.max(maxSum, list[0] + list[1]);
        }
    }

    return maxSum;
};