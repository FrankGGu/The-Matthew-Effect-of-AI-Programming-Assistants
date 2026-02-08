var minimizeSet = function(nums) {
    let n = nums.length;
    let maxNum = Math.max(...nums);
    let freq = new Array(maxNum + 1).fill(0);

    for (let num of nums) {
        freq[num]++;
    }

    let operations = 0;
    let distinctCount = 0;

    for (let i = 1; i <= maxNum; i++) {
        if (freq[i] > 0) {
            distinctCount++;
            operations += freq[i] - 1;
        }
    }

    while (distinctCount < n) {
        operations++;
        distinctCount++;
    }

    return operations;
};