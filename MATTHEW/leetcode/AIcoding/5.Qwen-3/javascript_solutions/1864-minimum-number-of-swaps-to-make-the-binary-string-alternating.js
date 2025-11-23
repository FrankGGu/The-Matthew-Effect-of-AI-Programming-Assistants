function minSwapsToMakeBinaryStringAlternating(s) {
    let count0 = 0, count1 = 0;
    for (let c of s) {
        if (c === '0') count0++;
        else count1++;
    }

    if (Math.abs(count0 - count1) > 1) return -1;

    let swap1 = 0, swap2 = 0;
    for (let i = 0; i < s.length; i++) {
        if (i % 2 === 0) {
            if (s[i] !== '0') swap1++;
            if (s[i] !== '1') swap2++;
        } else {
            if (s[i] !== '1') swap1++;
            if (s[i] !== '0') swap2++;
        }
    }

    if (count0 === count1) return Math.min(swap1, swap2);
    else if (count0 > count1) return swap1;
    else return swap2;
}