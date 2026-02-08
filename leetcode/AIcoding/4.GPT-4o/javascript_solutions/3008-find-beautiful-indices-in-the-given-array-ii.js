function beautifulIndices(nums) {
    const n = nums.length;
    let beautifulIndices = [];

    for (let i = 0; i < n; i++) {
        let leftSum = 0, rightSum = 0;

        for (let j = 0; j < i; j++) {
            leftSum += nums[j];
        }
        for (let j = i + 1; j < n; j++) {
            rightSum += nums[j];
        }

        if (leftSum === rightSum) {
            beautifulIndices.push(i);
        }
    }

    return beautifulIndices;
}