function minSuffixFlips(s) {
    let flips = 0;
    let last = '0';
    for (let c of s) {
        if (c !== last) {
            flips++;
            last = c;
        }
    }
    return flips;
}