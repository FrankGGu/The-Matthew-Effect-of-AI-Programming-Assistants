var sumDistance = function(nums, s, d) {
    const n = nums.length;
    const mod = 1e9 + 7;
    let positions = [...nums];

    for (let i = 0; i < n; i++) {
        if (s[i] === 'R') {
            positions[i] += d;
        } else {
            positions[i] -= d;
        }
    }

    positions.sort((a, b) => a - b);

    let res = 0;
    let prefix = 0;

    for (let i = 0; i < n; i++) {
        res = (res + positions[i] * i - prefix) % mod;
        prefix = (prefix + positions[i]) % mod;
    }

    return res;
};