function countSubarrays(nums, k) {
    const n = nums.length;
    const median = nums[k - 1];
    let count = 0;
    let balance = 0;
    const map = new Map();
    map.set(0, 1);

    for (let i = 0; i < n; i++) {
        if (nums[i] < median) {
            balance--;
        } else if (nums[i] > median) {
            balance++;
        }

        if (map.has(balance)) {
            count += map.get(balance);
        }

        map.set(balance, (map.get(balance) || 0) + 1);
    }

    return count;
}