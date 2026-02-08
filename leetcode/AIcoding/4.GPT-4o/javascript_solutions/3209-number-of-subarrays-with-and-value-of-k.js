var countSubarrays = function(nums, k) {
    let count = 0;
    let prefixCount = new Map();
    let prefixAnd = 0;

    for (let num of nums) {
        prefixAnd &= num;
        if (prefixAnd === k) count++;
        if (prefixCount.has(prefixAnd ^ k)) {
            count += prefixCount.get(prefixAnd ^ k);
        }
        prefixCount.set(prefixAnd, (prefixCount.get(prefixAnd) || 0) + 1);
    }

    return count;
};