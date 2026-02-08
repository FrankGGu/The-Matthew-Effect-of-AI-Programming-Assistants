var findLucky = function(arr) {
    const counts = {};
    for (const num of arr) {
        counts[num] = (counts[num] || 0) + 1;
    }

    let lucky = -1;
    for (const num in counts) {
        if (parseInt(num) === counts[num]) {
            lucky = Math.max(lucky, parseInt(num));
        }
    }

    return lucky;
};