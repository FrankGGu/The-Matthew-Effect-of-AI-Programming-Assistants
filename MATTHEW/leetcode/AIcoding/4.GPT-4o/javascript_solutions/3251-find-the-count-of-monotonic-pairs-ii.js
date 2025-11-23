var countMonotonicPairs = function(nums) {
    let count = 0;
    let n = nums.length;

    for (let i = 0; i < n; i++) {
        let leftCount = 1, rightCount = 1;
        for (let j = i + 1; j < n; j++) {
            if (nums[j] >= nums[j - 1]) rightCount++;
            else break;
        }
        for (let j = i - 1; j >= 0; j--) {
            if (nums[j] <= nums[j + 1]) leftCount++;
            else break;
        }
        count += leftCount * rightCount;
    }

    return count;
};