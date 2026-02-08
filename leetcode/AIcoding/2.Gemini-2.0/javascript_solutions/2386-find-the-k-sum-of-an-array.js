var kSum = function(nums, k) {
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] >= 0) {
            sum += nums[i];
        } else {
            nums[i] = -nums[i];
        }
    }
    nums.sort((a, b) => a - b);
    let pq = [[sum, 0]];
    let count = 0;
    while (count < k - 1) {
        let [currSum, currIndex] = pq.shift();
        count++;
        if (currIndex < nums.length) {
            pq.push([currSum - nums[currIndex], currIndex + 1]);
            pq.push([currSum, currIndex + 1]);
        }
        pq.sort((a, b) => b[0] - a[0]);
    }
    return pq[0][0];
};