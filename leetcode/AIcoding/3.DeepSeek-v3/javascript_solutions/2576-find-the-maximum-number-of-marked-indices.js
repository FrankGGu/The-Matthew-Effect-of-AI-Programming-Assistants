var maxNumOfMarkedIndices = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    let left = 0;
    let right = Math.floor(n / 2);
    let count = 0;

    while (left < Math.floor(n / 2) && right < n) {
        if (nums[left] * 2 <= nums[right]) {
            count++;
            left++;
            right++;
        } else {
            right++;
        }
    }

    return count * 2;
};