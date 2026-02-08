function minWindow(s, t) {
    if (t.length > s.length) return "";

    const dictT = {};
    for (char of t) {
        dictT[char] = (dictT[char] || 0) + 1;
    }

    let required = Object.keys(dictT).length;
    let l = 0, r = 0;
    let formed = 0;
    const windowCounts = {};

    let ans = [Infinity, null, null];

    while (r < s.length) {
        const char = s[r];
        windowCounts[char] = (windowCounts[char] || 0) + 1;

        if (char in dictT && windowCounts[char] === dictT[char]) {
            formed++;
        }

        while (l <= r && formed === required) {
            const char = s[l];

            if (r - l + 1 < ans[0]) {
                ans = [r - l + 1, l, r];
            }

            windowCounts[char]--;
            if (char in dictT && windowCounts[char] < dictT[char]) {
                formed--;
            }
            l++;
        }
        r++;
    }

    return ans[0] === Infinity ? "" : s.substring(ans[1], ans[2] + 1);
}