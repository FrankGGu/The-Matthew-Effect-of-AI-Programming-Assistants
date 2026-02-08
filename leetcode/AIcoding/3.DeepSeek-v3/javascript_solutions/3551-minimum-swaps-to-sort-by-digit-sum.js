var minimumSwaps = function(nums) {
    const digitSum = (num) => {
        let sum = 0;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }
        return sum;
    };

    const indexedNums = nums.map((num, index) => ({
        value: num,
        sum: digitSum(num),
        originalIndex: index
    }));

    indexedNums.sort((a, b) => {
        if (a.sum !== b.sum) {
            return a.sum - b.sum;
        } else {
            return a.originalIndex - b.originalIndex;
        }
    });

    let swaps = 0;
    const visited = new Array(nums.length).fill(false);

    for (let i = 0; i < nums.length; i++) {
        if (visited[i] || indexedNums[i].originalIndex === i) {
            continue;
        }

        let cycleSize = 0;
        let j = i;
        while (!visited[j]) {
            visited[j] = true;
            j = indexedNums[j].originalIndex;
            cycleSize++;
        }

        if (cycleSize > 0) {
            swaps += cycleSize - 1;
        }
    }

    return swaps;
};