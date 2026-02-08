var minimumOperations = function(nums, target) {
    const numsEven = [];
    const numsOdd = [];
    const targetEven = [];
    const targetOdd = [];

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] % 2 === 0) {
            numsEven.push(nums[i]);
        } else {
            numsOdd.push(nums[i]);
        }

        if (target[i] % 2 === 0) {
            targetEven.push(target[i]);
        } else {
            targetOdd.push(target[i]);
        }
    }

    numsEven.sort((a, b) => a - b);
    numsOdd.sort((a, b) => a - b);
    targetEven.sort((a, b) => a - b);
    targetOdd.sort((a, b) => a - b);

    let operations = 0;

    for (let i = 0; i < numsEven.length; i++) {
        operations += Math.abs(numsEven[i] - targetEven[i]);
    }

    for (let i = 0; i < numsOdd.length; i++) {
        operations += Math.abs(numsOdd[i] - targetOdd[i]);
    }

    // Each operation moves 1 unit. The total sum of absolute differences
    // represents the total value that needs to be moved.
    // Since each operation involves one decrease and one increase,
    // the total number of operations is half of the total absolute differences.
    // Also, (numsEven[i] - targetEven[i]) and (numsOdd[i] - targetOdd[i]) are always even,
    // so their sum is even, making the division by 2 valid.
    return operations / 2;
};