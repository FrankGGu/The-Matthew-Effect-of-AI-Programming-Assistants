var leftRigthDifference = function(nums) {
    const n = nums.length;
    const answer = new Array(n);

    let totalSum = 0;
    for (let i = 0; i < n; i++) {
        totalSum += nums[i];
    }

    let leftSum = 0;
    for (let i = 0; i < n; i++) {
        const rightSum = totalSum - leftSum - nums[i];
        answer[i] = Math.abs(leftSum - rightSum);
        leftSum += nums[i];
    }

    return answer;
};