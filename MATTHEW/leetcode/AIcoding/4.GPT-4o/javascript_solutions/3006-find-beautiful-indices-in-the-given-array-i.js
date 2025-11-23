function beautifulIndices(nums) {
    const n = nums.length;
    let results = [];

    for (let i = 0; i < n; i++) {
        let leftSum = 0, rightSum = 0;

        for (let j = 0; j < i; j++) {
            leftSum += nums[j];
        }

        for (let j = i + 1; j < n; j++) {
            rightSum += nums[j];
        }

        if (leftSum === rightSum) {
            results.push(i);
        }
    }

    return results;
}