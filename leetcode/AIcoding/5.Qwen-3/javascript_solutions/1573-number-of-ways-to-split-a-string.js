function numWays(s) {
    const MOD = 1000000007;
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '0') continue;
        count++;
    }
    if (count % 2 !== 0) return 0;
    if (count === 0) return (s.length - 1) % MOD;
    let first = 0, second = 0;
    let i = 0;
    while (i < s.length && first < count / 2) {
        if (s[i] === '1') first++;
        i++;
    }
    i++;
    while (i < s.length && second < count / 2) {
        if (s[i] === '1') second++;
        i++;
    }
    let left = i - 1;
    i = s.length - 1;
    while (i >= 0 && first < count / 2) {
        if (s[i] === '1') first++;
        i--;
    }
    let right = i + 1;
    return ((right - left) * (left - 0 + 1)) % MOD;
}