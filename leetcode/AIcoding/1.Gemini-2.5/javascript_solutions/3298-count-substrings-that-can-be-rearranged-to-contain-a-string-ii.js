var countSubstrings = function(s, target) {
    const n = s.length;
    const m = target.length;

    const targetFreq = new Array(26).fill(0);
    let targetUniqueChars = 0;
    for (let i = 0; i < m; i++) {
        const charCode = target.charCodeAt(i) - 97;
        if (targetFreq[charCode] === 0) {
            targetUniqueChars++;
        }
        targetFreq[charCode]++;
    }

    let ans = 0;
    let left = 0;
    const sFreq = new Array(26).fill(0);
    let matchCount = 0;

    for (let right = 0; right < n; right++) {
        const charCodeRight = s.charCodeAt(right) - 97;
        sFreq[charCodeRight]++;

        if (sFreq[charCodeRight] === targetFreq[charCodeRight]) {
            matchCount++;
        }

        while (matchCount === targetUniqueChars) {
            ans += (n - right);

            const charCodeLeft = s.charCodeAt(left) - 97;
            sFreq[charCodeLeft]--;

            if (sFreq[charCodeLeft] === targetFreq[charCodeLeft] - 1) {
                matchCount--;
            }
            left++;
        }
    }

    return ans;
};