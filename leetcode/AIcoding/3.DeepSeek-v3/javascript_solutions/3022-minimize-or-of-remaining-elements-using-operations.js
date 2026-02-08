var minOrAfterOperations = function(nums, k) {
    let res = 0;
    for (let bit = 30; bit >= 0; bit--) {
        res ^= (1 << bit);
        let cnt = 0;
        let current = res;
        for (const num of nums) {
            current &= num;
            if (current) {
                cnt++;
            } else {
                current = res;
            }
        }
        if (cnt > k) {
            res ^= (1 << bit);
        }
    }
    return res;
};