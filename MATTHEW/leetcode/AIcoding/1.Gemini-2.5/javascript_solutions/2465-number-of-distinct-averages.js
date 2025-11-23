var distinctAverages = function(nums) {
    nums.sort((a, b) => a - b);
    const averages = new Set();
    let left = 0;
    let right = nums.length - 1;

    while (left < right) {
        const avg = (nums[left] + nums[right]) / 2;
        averages.add(avg);
        left++;
        right--;
    }

    return averages.size;
};