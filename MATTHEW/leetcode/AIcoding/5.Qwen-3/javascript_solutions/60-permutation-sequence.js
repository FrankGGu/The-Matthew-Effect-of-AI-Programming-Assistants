function getPermutation(n, k) {
    let nums = [];
    for (let i = 1; i <= n; i++) {
        nums.push(i);
    }

    let factorial = 1;
    for (let i = 1; i < n; i++) {
        factorial *= i;
    }

    k--;
    let result = '';

    for (let i = 0; i < n; i++) {
        let index = Math.floor(k / factorial);
        result += nums[index];
        nums.splice(index, 1);
        k %= factorial;
        if (factorial > 1) {
            factorial /= (n - i - 1);
        }
    }

    return result;
}