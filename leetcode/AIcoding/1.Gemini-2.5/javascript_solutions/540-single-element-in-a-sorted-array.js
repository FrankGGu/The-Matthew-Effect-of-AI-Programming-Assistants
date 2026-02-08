var singleNonDuplicate = function(nums) {
    let low = 0;
    let high = nums.length - 1;

    while (low < high) {
        let mid = low + Math.floor((high - low) / 2);

        if (mid % 2 === 1) {
            mid--;
        }

        if (nums[mid] === nums[mid + 1]) {
            low = mid + 2;
        } else {
            high = mid;
        }
    }

    return nums[low];
};