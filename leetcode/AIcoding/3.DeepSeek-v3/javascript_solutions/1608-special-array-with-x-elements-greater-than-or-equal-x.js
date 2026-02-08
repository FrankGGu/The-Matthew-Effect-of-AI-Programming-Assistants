var specialArray = function(nums) {
    nums.sort((a, b) => b - a);
    let left = 0;
    let right = nums.length;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let count = 0;

        for (let num of nums) {
            if (num >= mid) {
                count++;
            } else {
                break;
            }
        }

        if (count === mid) {
            return mid;
        } else if (count > mid) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return -1;
};