var waysToMakeFair = function(nums) {
    let n = nums.length;
    let prefixEven = new Array(n + 1).fill(0);
    let prefixOdd = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            prefixEven[i + 1] = prefixEven[i] + nums[i];
            prefixOdd[i + 1] = prefixOdd[i];
        } else {
            prefixOdd[i + 1] = prefixOdd[i] + nums[i];
            prefixEven[i + 1] = prefixEven[i];
        }
    }

    let count = 0;
    for (let i = 0; i < n; i++) {
        let evenSum = prefixEven[i] + (prefixOdd[n] - prefixOdd[i + 1]);
        let oddSum = prefixOdd[i] + (prefixEven[n] - prefixEven[i + 1]);
        if (evenSum === oddSum) {
            count++;
        }
    }

    return count;
};