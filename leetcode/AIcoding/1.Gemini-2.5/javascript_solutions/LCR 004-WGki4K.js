var singleNumber = function(nums) {
    let result = 0;
    for (let i = 0; i < 32; i++) {
        let sum = 0;
        for (const num of nums) {
            if ((num >> i) & 1) {
                sum++;
            }
        }
        if (sum % 3 !== 0) {
            result |= (1 << i);
        }
    }
    return result;
};