var getPermutation = function(n, k) {
    let factorial = [1];
    let nums = [];
    for (let i = 1; i <= n; i++) {
        factorial[i] = factorial[i - 1] * i;
        nums.push(i);
    }

    k--;
    let result = "";
    for (let i = n - 1; i >= 0; i--) {
        let index = Math.floor(k / factorial[i]);
        result += nums[index];
        nums.splice(index, 1);
        k %= factorial[i];
    }

    return result;
};