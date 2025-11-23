var sumOfFlooredPairs = function(nums) {
    const MOD = 10**9 + 7;
    nums.sort((a, b) => a - b);
    const n = nums.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        let num = nums[i];
        let l = i;
        while (l < n && nums[l] === num) {
            l++;
        }

        let count = l - i;

        let left = num;
        while (left <= nums[n - 1]) {
            let right = left + num;

            let low = 0, high = n - 1;
            let leftIdx = -1;
            while (low <= high) {
                let mid = Math.floor((low + high) / 2);
                if (nums[mid] >= left) {
                    leftIdx = mid;
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }

            low = 0, high = n - 1;
            let rightIdx = -1;
            while (low <= high) {
                let mid = Math.floor((low + high) / 2);
                if (nums[mid] < right) {
                    rightIdx = mid;
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }

            if (leftIdx !== -1 && rightIdx !== -1) {
                ans = (ans + (Math.floor(left / num) * (rightIdx - leftIdx + 1) * count) % MOD) % MOD;
            }

            left += num;
        }

        i = l - 1;
    }

    return ans;
};