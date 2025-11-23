var countTriplets = function(nums) {
    const count = new Array(1 << 16).fill(0);
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            count[nums[i] & nums[j]]++;
        }
    }

    let res = 0;
    for (let k = 0; k < n; k++) {
        const num = nums[k];
        let mask = num ^ 0xffff;
        let sub = mask;
        do {
            res += count[sub];
            sub = (sub - 1) & mask;
        } while (sub !== mask);
    }

    return res;
};