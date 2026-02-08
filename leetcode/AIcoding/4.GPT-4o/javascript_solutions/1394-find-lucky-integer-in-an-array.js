var findLucky = function(arr) {
    const count = {};
    for (const num of arr) {
        count[num] = (count[num] || 0) + 1;
    }
    let lucky = -1;
    for (const num in count) {
        if (num == count[num]) {
            lucky = Math.max(lucky, num);
        }
    }
    return lucky;
};