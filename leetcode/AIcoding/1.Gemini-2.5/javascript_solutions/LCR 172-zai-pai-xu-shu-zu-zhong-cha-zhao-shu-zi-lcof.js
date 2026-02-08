var search = function(nums, target) {
    const findInsertionPoint = (arr, val) => {
        let left = 0;
        let right = arr.length;
        let ans = arr.length;

        while (left < right) {
            let mid = Math.floor((left + right) / 2);
            if (arr[mid] >= val) {
                ans = mid;
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    };

    const firstGreaterOrEqual = findInsertionPoint(nums, target);
    const firstGreater = findInsertionPoint(nums, target + 1);

    return firstGreater - firstGreaterOrEqual;
};