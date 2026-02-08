var isGood = function(nums) {
    const n = Math.max(...nums);

    if (nums.length !== n + 1) {
        return false;
    }

    const counts = new Array(n + 1).fill(0); 

    for (const num of nums) {
        counts[num]++;
    }

    for (let i = 1; i < n; i++) {
        if (counts[i] !== 1) {
            return false;
        }
    }

    if (counts[n] !== 2) {
        return false;
    }

    return true;
};