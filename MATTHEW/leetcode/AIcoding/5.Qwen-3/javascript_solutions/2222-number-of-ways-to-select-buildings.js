function numberOfWays(s) {
    const n = s.length;
    let count0 = 0, count1 = 0;
    let total = 0;

    for (let i = 0; i < n; i++) {
        if (s[i] === '0') {
            count0++;
        } else {
            count1++;
        }
    }

    let left0 = 0, left1 = 0;

    for (let i = 0; i < n; i++) {
        if (s[i] === '0') {
            total += left1 * (count1 - left1);
            left0++;
        } else {
            total += left0 * (count0 - left0);
            left1++;
        }
    }

    return total;
}