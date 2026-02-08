function getPermutation(n, k) {
    let nums = Array.from({length: n}, (_, i) => i + 1);
    let factorial = Array.from({length: n}, (_, i) => i === 0 ? 1 : factorial[i - 1] * i);
    k--; // convert to 0-indexed
    let result = '';

    for (let i = 1; i <= n; i++) {
        let index = Math.floor(k / factorial[n - i]);
        result += nums[index];
        nums.splice(index, 1);
        k %= factorial[n - i];
    }

    return result;
}