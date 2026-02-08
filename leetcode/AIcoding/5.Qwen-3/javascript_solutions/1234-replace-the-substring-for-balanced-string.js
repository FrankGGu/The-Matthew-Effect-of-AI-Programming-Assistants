function replaceSubstring(s, k) {
    const count = new Map();
    const n = s.length;
    let minLen = n;
    let left = 0;

    for (let right = 0; right < n; right++) {
        count.set(s[right], (count.get(s[right]) || 0) + 1);

        while (count.size === 4) {
            minLen = Math.min(minLen, right - left + 1);
            count.set(s[left], count.get(s[left]) - 1);
            if (count.get(s[left]) === 0) {
                count.delete(s[left]);
            }
            left++;
        }
    }

    return minLen;
}