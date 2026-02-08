function minWindow(s, t) {
    if (!t || !s) return "";

    const map = new Map();
    for (const char of t) {
        map.set(char, (map.get(char) || 0) + 1);
    }

    let left = 0, right = 0, start = 0, minLength = Infinity, count = 0;

    while (right < s.length) {
        if (map.has(s[right])) {
            if (map.get(s[right]) > 0) count++;
            map.set(s[right], map.get(s[right]) - 1);
        }
        right++;

        while (count === t.length) {
            if (right - left < minLength) {
                minLength = right - left;
                start = left;
            }
            if (map.has(s[left])) {
                if (map.get(s[left]) === 0) count--;
                map.set(s[left], map.get(s[left]) + 1);
            }
            left++;
        }
    }

    return minLength === Infinity ? "" : s.substring(start, start + minLength);
}