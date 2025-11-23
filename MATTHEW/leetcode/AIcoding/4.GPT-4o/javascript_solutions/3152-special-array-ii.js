var specialArray = function(nums) {
    let left = 0, right = nums.length;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let count = nums.filter(num => num >= mid).length;

        if (count === mid) {
            return mid;
        } else if (count < mid) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return -1;
};