var minimizeArrayValue = function(nums) {
    let low = 0;
    let high = Math.max(...nums);
    let ans = high;

    const canAchieve = (x) => {
        let currentSum = 0;
        for (let i = 0; i < nums.length; i++) {
            currentSum += nums[i];
            // If the average of the first (i+1) elements is greater than x,
            // it's impossible to make all elements in this prefix <= x.
            // currentSum / (i+1) > x  <=>  currentSum > (i+1) * x
            // Using BigInt to prevent overflow for large sums, though JS numbers handle up to 2^53-1 safely.
            // For sums up to 10^5 * 10^9 = 10^14, standard JS numbers are fine.
            if (currentSum > (i + 1) * x) {
                return false;
            }
        }
        return true;
    };

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (canAchieve(mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};