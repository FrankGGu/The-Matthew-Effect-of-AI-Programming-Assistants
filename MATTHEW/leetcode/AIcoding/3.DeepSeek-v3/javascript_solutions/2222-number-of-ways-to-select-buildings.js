var numberOfWays = function(s) {
    let count0 = 0, count1 = 0;
    for (let c of s) {
        if (c === '0') count0++;
        else count1++;
    }

    let res = 0;
    let curr0 = 0, curr1 = 0;
    for (let c of s) {
        if (c === '0') {
            res += curr1 * (count1 - curr1);
            curr0++;
        } else {
            res += curr0 * (count0 - curr0);
            curr1++;
        }
    }
    return res;
};