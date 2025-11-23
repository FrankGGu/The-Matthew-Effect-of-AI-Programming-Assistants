var checkDynasty = function(places) {
    let zeroCount = 0;
    let min = 14, max = 0;
    const set = new Set();

    for (const num of places) {
        if (num === 0) {
            zeroCount++;
        } else {
            if (set.has(num)) return false;
            set.add(num);
            min = Math.min(min, num);
            max = Math.max(max, num);
        }
    }

    return max - min < 5;
};