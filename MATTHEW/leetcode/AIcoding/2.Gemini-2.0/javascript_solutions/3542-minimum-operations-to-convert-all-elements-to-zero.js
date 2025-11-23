var minimumOperations = function(nums) {
    let count = 0;
    let set = new Set();
    for (let num of nums) {
        if (num > 0) {
            set.add(num);
        }
    }

    while (set.size > 0) {
        let minVal = Math.min(...set);
        count++;

        let newSet = new Set();
        for (let num of nums) {
            let diff = num - minVal;
            if (diff > 0) {
                newSet.add(diff);
            }
        }
        set = newSet;
        nums = Array.from(set);
    }

    return count;
};