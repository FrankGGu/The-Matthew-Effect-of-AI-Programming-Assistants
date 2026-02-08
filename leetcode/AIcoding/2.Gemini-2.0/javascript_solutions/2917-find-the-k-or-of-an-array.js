var findKOr = function(nums, k) {
    let result = 0;
    for (let i = 0; i < 31; i++) {
        let count = 0;
        for (let num of nums) {
            if ((num >> i) & 1) {
                count++;
            }
        }
        if (count >= k) {
            result |= (1 << i);
        }
    }
    return result;
};