function minimumTime(s) {
    const n = s.length;
    let res = 0;
    let last = -1;
    for (let i = 0; i < n; i++) {
        if (s[i] === '0') continue;
        if (last === -1 || i - last > m) {
            res += m;
            last = i;
        } else {
            res += i - last;
            last = i;
        }
    }
    return res;
}