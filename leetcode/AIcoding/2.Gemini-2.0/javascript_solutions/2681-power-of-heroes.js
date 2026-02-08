var sumOfPower = function(nums) {
    nums.sort((a, b) => a - b);
    let mod = 10**9 + 7;
    let sum = 0;
    let ans = 0;

    for (let i = 0; i < nums.length; i++) {
        let num = nums[i];
        ans = (ans + (num * num % mod) * (num + sum) % mod) % mod;
        sum = (sum * 2 % mod + num) % mod;
    }

    return ans;
};