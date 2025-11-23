function minAppendValue(nums, k) {
    nums.sort((a, b) => a - b);
    let sum = 0;
    let current = 1;
    for (let i = 0; i < nums.length && k > 0; i++) {
        if (nums[i] > current) {
            sum += current;
            k--;
            current++;
        } else {
            current = nums[i] + 1;
        }
    }
    while (k > 0) {
        sum += current;
        k--;
        current++;
    }
    return sum;
}