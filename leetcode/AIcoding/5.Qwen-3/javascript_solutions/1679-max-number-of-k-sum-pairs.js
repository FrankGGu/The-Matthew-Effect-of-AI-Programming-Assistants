var maxOperations = function(nums, k) {
    const count = {};
    let operations = 0;

    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    for (const num of nums) {
        const complement = k - num;
        if (count[num] === 0) continue;
        if (complement in count && count[complement] > 0) {
            if (num === complement) {
                if (count[num] >= 2) {
                    operations++;
                    count[num] -= 2;
                }
            } else {
                operations++;
                count[num]--;
                count[complement]--;
            }
        }
    }

    return operations;
};