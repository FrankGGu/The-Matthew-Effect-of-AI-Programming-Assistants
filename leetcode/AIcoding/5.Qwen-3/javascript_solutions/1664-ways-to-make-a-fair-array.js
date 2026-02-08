function waysToMakeFair(nums) {
    const n = nums.length;
    let total = 0;
    for (let i = 0; i < n; i++) {
        total += nums[i];
    }

    let leftSum = 0;
    let rightSum = 0;
    let count = 0;

    for (let i = 0; i < n; i++) {
        rightSum = total - leftSum - nums[i];

        if (leftSum === rightSum) {
            count++;
        }

        leftSum += nums[i];
    }

    return count;
}