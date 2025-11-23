function isTransformable(s, t) {
    const countS = new Array(10).fill(0);
    const countT = new Array(10).fill(0);

    for (const char of s) countS[char - '0']++;
    for (const char of t) countT[char - '0']++;

    for (let i = 0; i < 10; i++) {
        if (countS[i] < countT[i]) return false;
    }

    let j = 0;
    for (let i = 0; i < 10; i++) {
        while (countT[i] > 0) {
            while (j < s.length && (s[j] - '0') < i) j++;
            if (j === s.length) return false;
            if (s[j] - '0' === i) {
                countT[i]--;
                countS[i]--;
            }
            j++;
        }
    }

    return true;
}