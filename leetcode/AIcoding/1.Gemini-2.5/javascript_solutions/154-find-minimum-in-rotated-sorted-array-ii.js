var findMin = function(nums) {
    let low = 0;
    let high = nums.length - 1;

    while (low < high) {
        let mid = low + Math.floor((high - low) / 2);

        if (nums[mid] > nums[high]) {
            // The minimum is in the right half (mid+1 to high)
            low = mid + 1;
        } else if (nums[mid] < nums[high]) {
            // The minimum is in the left half (low to mid), possibly mid itself
            high = mid;
        } else {
            // nums[mid] == nums[high]
            // We cannot determine which half contains the minimum from this comparison alone
            // Safely discard high as it's a duplicate or not the minimum we are looking for
            high--;
        }
    }

    return nums[low];
};