var minDeletions = function(nums, gcd) {
    let n = nums.length;
    nums.sort((a, b) => a - b);

    let cnt = 0;
    for (let i = 0; i < n; i++) {
        if (gcd % nums[i] !== 0) {
            cnt++;
        } else {
            break;
        }
    }

    return cnt + (n - (n - cnt));
};