var countSubarrays = function(nums, k) {
    const n = nums.length;
    let kIndex = nums.indexOf(k);
    let count = new Map();
    count.set(0, 1);
    let balance = 0;
    let res = 0;

    for (let i = 0; i < n; i++) {
        if (nums[i] < k) {
            balance--;
        } else if (nums[i] > k) {
            balance++;
        }

        if (i < kIndex) {
            if (!count.has(balance)) {
                count.set(balance, 0);
            }
            count.set(balance, count.get(balance) + 1);
        } else {
            res += (count.get(balance) || 0) + (count.get(balance - 1) || 0);
        }
    }

    return res;
};