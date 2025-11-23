var minimumSwaps = function(nums) {
    const n = nums.length;
    if (n <= 1) {
        return 0;
    }

    const getDigitSum = (num) => {
        let sum = 0;
        let temp = num;
        while (temp > 0) {
            sum += temp % 10;
            temp = Math.floor(temp / 10);
        }
        return sum;
    };

    const items = [];
    for (let i = 0; i < n; i++) {
        items.push({
            value: nums[i],
            digitSum: getDigitSum(nums[i]),
            originalIndex: i
        });
    }

    items.sort((a, b) => {
        if (a.digitSum !== b.digitSum) {
            return a.digitSum - b.digitSum;
        }
        return a.value - b.value;
    });

    let swaps = 0;
    const visited = new Array(n).fill(false);

    for (let i = 0; i < n; i++) {
        if (visited[i] || items[i].originalIndex === i) {
            continue;
        }

        let cycleSize = 0;
        let currentIndex = i;

        while (!visited[currentIndex]) {
            visited[currentIndex] = true;
            currentIndex = items[currentIndex].originalIndex;
            cycleSize++;
        }
        swaps += (cycleSize - 1);
    }

    return swaps;
};