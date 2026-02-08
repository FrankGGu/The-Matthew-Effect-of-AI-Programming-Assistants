var findMaximumXOR = function(nums) {
    let max_xor = 0;
    let mask = 0;
    let seen = new Set();

    for (let i = 31; i >= 0; i--) {
        mask |= (1 << i);
        seen.clear();

        for (let num of nums) {
            seen.add(num & mask);
        }

        let potential_max = max_xor | (1 << i);
        for (let prefix of seen) {
            if (seen.has(potential_max ^ prefix)) {
                max_xor = potential_max;
                break;
            }
        }
    }

    return max_xor;
};