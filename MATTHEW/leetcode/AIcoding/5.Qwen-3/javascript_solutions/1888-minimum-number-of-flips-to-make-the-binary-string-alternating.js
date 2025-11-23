function minFlips(s) {
    let n = s.length;
    let flip0 = 0, flip1 = 0;
    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            if (s[i] !== '0') flip0++;
            if (s[i] !== '1') flip1++;
        } else {
            if (s[i] !== '1') flip0++;
            if (s[i] !== '0') flip1++;
        }
    }
    return Math.min(flip0, flip1);
}