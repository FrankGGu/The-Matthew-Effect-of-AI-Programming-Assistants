function uniqueLetterString(s) {
    const n = s.length;
    const pre = new Array(n).fill(0);
    const next = new Array(n).fill(0);
    const last = new Map();

    for (let i = 0; i < n; i++) {
        const c = s[i];
        if (last.has(c)) {
            pre[i] = last.get(c) + 1;
        } else {
            pre[i] = 0;
        }
        last.set(c, i);
    }

    last.clear();

    for (let i = n - 1; i >= 0; i--) {
        const c = s[i];
        if (last.has(c)) {
            next[i] = last.get(c) - 1;
        } else {
            next[i] = n - 1;
        }
        last.set(c, i);
    }

    let res = 0;
    for (let i = 0; i < n; i++) {
        res += (i - pre[i]) * (next[i] - i);
    }

    return res;
}