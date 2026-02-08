var minWindow = function(s, t) {
    const map = {};
    for (const char of t) {
        map[char] = (map[char] || 0) + 1;
    }
    let left = 0, right = 0, count = t.length;
    let minLen = Infinity, minStart = 0;

    while (right < s.length) {
        if (map[s[right]] !== undefined) {
            if (map[s[right]] > 0) count--;
            map[s[right]]--;
        }
        right++;

        while (count === 0) {
            if (right - left < minLen) {
                minLen = right - left;
                minStart = left;
            }
            if (map[s[left]] !== undefined) {
                map[s[left]]++;
                if (map[s[left]] > 0) count++;
            }
            left++;
        }
    }

    return minLen === Infinity ? "" : s.substr(minStart, minLen);
};