var countTriplets = function(nums) {
    let count = 0;
    for (let i = 0; i <= nums.length - 3; i++) {
        // Assuming the condition is that the middle element is strictly greater than its neighbors
        if (nums[i+1] > nums[i] && nums[i+1] > nums[i+2]) {
            count++;
        }
    }
    return count;
};