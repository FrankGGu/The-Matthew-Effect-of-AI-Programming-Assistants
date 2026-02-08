var minFlips = function(s) {
    const n = s.length;
    s = s + s;
    let alt1 = '', alt2 = '';
    for (let i = 0; i < s.length; i++) {
        alt1 += i % 2 === 0 ? '0' : '1';
        alt2 += i % 2 === 0 ? '1' : '0';
    }

    let res = Infinity;
    let diff1 = 0, diff2 = 0;
    let left = 0;

    for (let right = 0; right < s.length; right++) {
        if (s[right] !== alt1[right]) diff1++;
        if (s[right] !== alt2[right]) diff2++;

        if (right - left + 1 > n) {
            if (s[left] !== alt1[left]) diff1--;
            if (s[left] !== alt2[left]) diff2--;
            left++;
        }

        if (right - left + 1 === n) {
            res = Math.min(res, diff1, diff2);
        }
    }

    return res;
};