var shortestSuperstring = function(words) {
    const n = words.length;

    const calculateOverlap = (s1, s2) => {
        let maxOverlap = 0;
        for (let k = 1; k <= Math.min(s1.length, s2.length); k++) {
            if (s1.substring(s1.length - k) === s2.substring(0, k)) {
                maxOverlap = k;
            }
        }
        return maxOverlap;
    };

    const overlap = Array(n).fill(0).map(() => Array(n).fill(0));
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            overlap[i][j] = calculateOverlap(words[i], words[j]);
        }
    }

    const dp = Array(1 << n).fill(0).map(() => Array(n).fill(Infinity));
    const parent = Array(1 << n).fill(0).map(() => Array(n).fill(-1));

    for (let i = 0; i < n; i++) {
        dp[1 << i][i] = words[i].length;
    }

    for (let mask = 1; mask < (1 << n); mask++) {
        for (let i = 0; i < n; i++) {
            if (!((mask >> i) & 1)) continue;

            for (let j = 0; j < n; j++) {
                if (i === j || !((mask >> j) & 1)) continue;

                const prevMask = mask ^ (1 << i);
                const currentLen = dp[prevMask][j] + words[i].length - overlap[j][i];

                if (currentLen < dp[mask][i]) {
                    dp[mask][i] = currentLen;
                    parent[mask][i] = j;
                }
            }
        }
    }

    let minLen = Infinity;
    let lastWordIdx = -1;
    const finalMask = (1 << n) - 1;

    for (let i = 0; i < n; i++) {
        if (dp[finalMask][i] < minLen) {
            minLen = dp[finalMask][i];
            lastWordIdx = i;
        }
    }

    const path = [];
    let currentMask = finalMask;
    let currentLastWord = lastWordIdx;

    while (currentMask > 0) {
        path.unshift(currentLastWord);
        const prevWord = parent[currentMask][currentLastWord];
        currentMask ^= (1 << currentLastWord);
        currentLastWord = prevWord;
    }

    let result = words[path[0]];
    for (let k = 1; k < n; k++) {
        const prevIdx = path[k - 1];
        const currIdx = path[k];
        const o = overlap[prevIdx][currIdx];
        result += words[currIdx].substring(o);
    }

    return result;
};