function beautifulPairs(nums, s) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    let result = 0;
    for (let i = 0; i < nums.length; i++) {
        const a = nums[i];
        const b = s[i];
        if (count[a] > 0 && count[b] > 0) {
            if (a === b) {
                if (count[a] >= 2) {
                    count[a] -= 2;
                    result++;
                }
            } else {
                count[a]--;
                count[b]--;
                result++;
            }
        }
    }
    return result;
}