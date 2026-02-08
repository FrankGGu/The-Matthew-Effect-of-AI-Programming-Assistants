var subarraysDivByK = function(nums, k) {
    let count = 0;
    let sum = 0;
    let remainderMap = new Map();
    remainderMap.set(0, 1);

    for (let num of nums) {
        sum = (sum + num) % k;
        if (sum < 0) {
            sum += k;
        }

        if (remainderMap.has(sum)) {
            count += remainderMap.get(sum);
            remainderMap.set(sum, remainderMap.get(sum) + 1);
        } else {
            remainderMap.set(sum, 1);
        }
    }

    return count;
};