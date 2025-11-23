var divideArray = function(nums) {
    const counts = new Map();

    for (const num of nums) {
        counts.set(num, (counts.get(num) || 0) + 1);
    }

    for (const count of counts.values()) {
        if (count % 2 !== 0) {
            return false;
        }
    }

    return true;
};