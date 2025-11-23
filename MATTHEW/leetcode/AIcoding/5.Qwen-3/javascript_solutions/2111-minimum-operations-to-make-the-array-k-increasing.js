function minOperations(nums, k) {
    function lis(arr) {
        let dp = [];
        for (let num of arr) {
            let left = 0, right = dp.length;
            while (left < right) {
                let mid = Math.floor((left + right) / 2);
                if (dp[mid] <= num) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            if (left === dp.length) {
                dp.push(num);
            } else {
                dp[left] = num;
            }
        }
        return dp.length;
    }

    let result = 0;
    for (let i = 0; i < k; i++) {
        let sub = [];
        for (let j = i; j < nums.length; j += k) {
            sub.push(nums[j]);
        }
        result += sub.length - lis(sub);
    }
    return result;
}