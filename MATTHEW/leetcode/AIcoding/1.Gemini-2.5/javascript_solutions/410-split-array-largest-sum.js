var splitArray = function(nums, m) {
    let low = 0;
    let high = 0;

    for (let num of nums) {
        low = Math.max(low, num);
        high += num;
    }

    let ans = high;

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);

        if (canSplit(nums, m, mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};

function canSplit(nums, m, largestSum) {
    let currentSum = 0;
    let subarrays = 1;

    for (let num of nums) {
        if (currentSum + num <= largestSum) {
            currentSum += num;
        } else {
            subarrays++;
            currentSum = num;
            if (subarrays > m || num > largestSum) { // num > largestSum check is mostly redundant if low is initialized correctly
                return false;
            }
        }
    }
    return true;
}