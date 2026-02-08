var countBeautifulSubarrays = function(nums) {
    let count = 0;
    const prefix = new Map();
    prefix.set(0, 1);
    let currentXor = 0;

    for (let num of nums) {
        currentXor ^= num;
        count += prefix.get(currentXor) || 0;
        prefix.set(currentXor, (prefix.get(currentXor) || 0) + 1);
    }

    return count;
};