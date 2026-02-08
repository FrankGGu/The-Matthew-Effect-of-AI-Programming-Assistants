var countLargestGroup = function(n) {
    const sumCounts = new Array(37).fill(0);

    for (let i = 1; i <= n; i++) {
        let currentNum = i;
        let digitSum = 0;
        while (currentNum > 0) {
            digitSum += currentNum % 10;
            currentNum = Math.floor(currentNum / 10);
        }
        sumCounts[digitSum]++;
    }

    let maxFreq = 0;
    for (let i = 0; i < sumCounts.length; i++) {
        if (sumCounts[i] > maxFreq) {
            maxFreq = sumCounts[i];
        }
    }

    let countOfLargestGroups = 0;
    for (let i = 0; i < sumCounts.length; i++) {
        if (sumCounts[i] === maxFreq) {
            countOfLargestGroups++;
        }
    }

    return countOfLargestGroups;
};