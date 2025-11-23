var minImpossibleOR = function(nums) {
    const set = new Set(nums);
    for (let i = 0; i < 32; i++) {
        const powerOfTwo = 1 << i;
        if (!set.has(powerOfTwo)) {
            return powerOfTwo;
        }
    }
    return -1;
};