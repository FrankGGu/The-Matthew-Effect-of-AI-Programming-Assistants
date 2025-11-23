var sumOfFlooredPairs = function(nums) {
    const maxNum = Math.max(...nums);
    const count = new Array(maxNum + 1).fill(0);

    for (const num of nums) {
        count[num]++;
    }

    const sum = new Array(maxNum + 1).fill(0);

    for (let i = 1; i <= maxNum; i++) {
        for (let j = i; j <= maxNum; j += i) {
            sum[j] += count[i];
        }
    }

    let result = 0;
    for (const num of nums) {
        result += sum[num];
    }

    return result;
};