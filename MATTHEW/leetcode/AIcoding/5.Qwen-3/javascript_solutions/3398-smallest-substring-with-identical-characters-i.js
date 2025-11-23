function smallestSubstring(s) {
    const n = s.length;
    let minLen = Infinity;
    const count = {};
    let left = 0;
    let unique = 0;

    for (let right = 0; right < n; right++) {
        const char = s[right];
        if (count[char] === undefined) {
            count[char] = 0;
            unique++;
        }
        count[char]++;

        while (unique === 1) {
            minLen = Math.min(minLen, right - left + 1);
            const leftChar = s[left];
            count[leftChar]--;
            if (count[leftChar] === 0) {
                unique--;
            }
            left++;
        }
    }

    return minLen === Infinity ? "" : s.substring(0, minLen);
}