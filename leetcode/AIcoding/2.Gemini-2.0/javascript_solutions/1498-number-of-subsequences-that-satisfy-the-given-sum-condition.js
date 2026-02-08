var numSubseq = function(nums, target) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let mod = 10**9 + 7;
    let ans = 0;
    let powers = new Array(n).fill(0);
    powers[0] = 1;
    for (let i = 1; i < n; i++) {
        powers[i] = (powers[i - 1] * 2) % mod;
    }

    for (let i = 0; i < n; i++) {
        let left = i;
        let right = n - 1;
        let index = -1;
        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            if (nums[i] + nums[mid] <= target) {
                index = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (index !== -1) {
            ans = (ans + powers[index - i]) % mod;
        }
    }

    return ans;
};