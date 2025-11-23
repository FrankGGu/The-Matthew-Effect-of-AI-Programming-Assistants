function rotateFunction(nums) {
    const n = nums.length;
    let f = 0;
    let sum = 0;

    for (let i = 0; i < n; i++) {
        f += i * nums[i];
        sum += nums[i];
    }

    const result = [f];

    for (let i = 1; i < n; i++) {
        f = f + sum - n * nums[n - i];
        result.push(f);
    }

    return result;
}