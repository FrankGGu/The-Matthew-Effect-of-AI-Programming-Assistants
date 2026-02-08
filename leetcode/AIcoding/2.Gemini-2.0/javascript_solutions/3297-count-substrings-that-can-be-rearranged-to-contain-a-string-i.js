var countSubstrings = function(s, t) {
    const n = s.length;
    const m = t.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            const sub = s.substring(i, j + 1);
            if (sub.length >= m) {
                const subCharCounts = {};
                for (const char of sub) {
                    subCharCounts[char] = (subCharCounts[char] || 0) + 1;
                }

                const tCharCounts = {};
                for (const char of t) {
                    tCharCounts[char] = (tCharCounts[char] || 0) + 1;
                }

                let possible = true;
                for (const char in tCharCounts) {
                    if (!(char in subCharCounts) || subCharCounts[char] < tCharCounts[char]) {
                        possible = false;
                        break;
                    }
                }

                if (possible) {
                    count++;
                }
            }
        }
    }

    return count;
};