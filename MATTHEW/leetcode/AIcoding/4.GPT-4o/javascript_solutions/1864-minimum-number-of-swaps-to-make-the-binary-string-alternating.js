function minSwaps(s) {
    let count0 = 0, count1 = 0;
    for (let char of s) {
        if (char === '0') count0++;
        else count1++;
    }

    if (Math.abs(count0 - count1) > 1) return -1;

    const expected1 = "0101010101"; // could be longer based on length of s
    const expected2 = "1010101010"; // could be longer based on length of s
    let swaps1 = 0, swaps2 = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] !== expected1[i % 2]) swaps1++;
        if (s[i] !== expected2[i % 2]) swaps2++;
    }

    return Math.floor(Math.min(swaps1, swaps2) / 2);
}