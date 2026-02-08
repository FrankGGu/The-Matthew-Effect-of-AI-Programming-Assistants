var minWindow = function(s, t) {
    if (s.length === 0 || t.length === 0) return "";

    const map = {};
    for (const char of t) {
        map[char] = (map[char] || 0) + 1;
    }

    let required = Object.keys(map).length;
    let left = 0, right = 0;
    let formed = 0;
    const windowCounts = {};

    let ans = [-1, 0, 0];

    while (right < s.length) {
        const char = s[right];
        windowCounts[char] = (windowCounts[char] || 0) + 1;

        if (map[char] && windowCounts[char] === map[char]) {
            formed++;
        }

        while (left <= right && formed === required) {
            const currentChar = s[left];

            if (ans[0] === -1 || right - left + 1 < ans[0]) {
                ans[0] = right - left + 1;
                ans[1] = left;
                ans[2] = right;
            }

            windowCounts[currentChar]--;
            if (map[currentChar] && windowCounts[currentChar] < map[currentChar]) {
                formed--;
            }

            left++;
        }

        right++;
    }

    return ans[0] === -1 ? "" : s.substring(ans[1], ans[2] + 1);
};