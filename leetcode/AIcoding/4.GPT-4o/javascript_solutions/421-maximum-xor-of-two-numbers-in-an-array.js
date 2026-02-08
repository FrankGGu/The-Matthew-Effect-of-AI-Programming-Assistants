var findMaximumXOR = function(nums) {
    let maxNum = Math.max(...nums);
    let mask = 0;
    let result = 0;

    for (let i = 31; i >= 0; i--) {
        mask |= (1 << i);
        let prefixes = new Set();

        for (let num of nums) {
            prefixes.add(num & mask);
        }

        let temp = result | (1 << i);
        for (let prefix of prefixes) {
            if (prefixes.has(temp ^ prefix)) {
                result = temp;
                break;
            }
        }
    }

    return result;
};