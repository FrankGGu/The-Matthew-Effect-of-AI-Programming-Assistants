var searchRange = function(nums, target) {
    const findIndex = (isFirst) => {
        let left = 0, right = nums.length - 1, index = -1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (nums[mid] === target) {
                index = mid;
                isFirst ? right = mid - 1 : left = mid + 1;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return index;
    };

    const first = findIndex(true);
    if (first === -1) return [-1, -1];
    const last = findIndex(false);
    return [first, last];
};