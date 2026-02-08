var minimalKSum = function(nums, k) {
    nums.sort((a, b) => a - b);
    let res = 0;
    let prev = 0;
    for (const num of nums) {
        if (num === prev) continue;
        const count = Math.min(num - prev - 1, k);
        if (count <= 0) {
            prev = num;
            continue;
        }
        res += (prev + 1 + prev + count) * count / 2;
        k -= count;
        if (k === 0) break;
        prev = num;
    }
    if (k > 0) {
        res += (prev + 1 + prev + k) * k / 2;
    }
    return res;
};