var searchRange = function(nums, target) {
    const findFirst = (nums, target) => {
        let low = 0;
        let high = nums.length - 1;
        let first = -1;

        while (low <= high) {
            let mid = Math.floor(low + (high - low) / 2);
            if (nums[mid] === target) {
                first = mid;
                high = mid - 1;
            } else if (nums[mid] < target) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return first;
    };

    const findLast = (nums, target) => {
        let low = 0;
        let high = nums.length - 1;
        let last = -1;

        while (low <= high) {
            let mid = Math.floor(low + (high - low) / 2);
            if (nums[mid] === target) {
                last = mid;
                low = mid + 1;
            } else if (nums[mid] < target) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return last;
    };

    const firstPos = findFirst(nums, target);
    const lastPos = findLast(nums, target);

    return [firstPos, lastPos];
};