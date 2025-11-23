var minSwaps = function(s) {
    let count1 = 0, count0 = 0;
    for (let c of s) {
        if (c === '1') count1++;
        else count0++;
    }

    if (Math.abs(count1 - count0) > 1) return -1;

    const countSwaps = (start) => {
        let swaps = 0;
        for (let i = 0; i < s.length; i++) {
            const expected = start ^ (i % 2);
            if (parseInt(s[i]) !== expected) swaps++;
        }
        return Math.floor(swaps / 2);
    };

    if (count1 > count0) {
        return countSwaps(1);
    } else if (count0 > count1) {
        return countSwaps(0);
    } else {
        return Math.min(countSwaps(0), countSwaps(1));
    }
};