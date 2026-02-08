function countSubstrings(s, t) {
    const m = s.length;
    const n = t.length;
    let count = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let diff = 0;
            let x = i;
            let y = j;
            while (x < m && y < n) {
                if (s[x] !== t[y]) {
                    diff++;
                }
                if (diff === 1) {
                    count++;
                } else if (diff > 1) {
                    break;
                }
                x++;
                y++;
            }
        }
    }

    return count;
}