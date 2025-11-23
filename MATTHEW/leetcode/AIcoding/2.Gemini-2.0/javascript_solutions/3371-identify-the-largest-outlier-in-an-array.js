var findLargestOutlier = function(nums) {
    if (nums.length < 3) {
        return -1;
    }

    const sortedNums = [...nums].sort((a, b) => a - b);
    const median = sortedNums[1];

    if (nums[0] > nums[1]) {
        if (nums[0] > nums[2]) {
            if (Math.abs(nums[0] - median) > Math.abs(nums[1] - median) && Math.abs(nums[0] - median) > Math.abs(nums[2] - median)){
                return nums[0];
            }
        }
    } else {
        if (nums[1] > nums[2]) {
             if (Math.abs(nums[1] - median) > Math.abs(nums[0] - median) && Math.abs(nums[1] - median) > Math.abs(nums[2] - median)){
                return nums[1];
            }
        }
    }
        if (nums[2] > nums[0]) {
        if (nums[2] > nums[1]) {
             if (Math.abs(nums[2] - median) > Math.abs(nums[0] - median) && Math.abs(nums[2] - median) > Math.abs(nums[1] - median)){
                return nums[2];
            }
        }
    }

    const avg = nums.reduce((sum, num) => sum + num, 0) / nums.length;
    const stdDev = Math.sqrt(nums.reduce((sum, num) => sum + Math.pow(num - avg, 2), 0) / nums.length);

    let largestOutlier = -1;
    let maxZScore = 0;

    for (const num of nums) {
        const zScore = Math.abs((num - avg) / stdDev);
        if (zScore > maxZScore) {
            maxZScore = zScore;
            largestOutlier = num;
        }
    }

    return largestOutlier;
};