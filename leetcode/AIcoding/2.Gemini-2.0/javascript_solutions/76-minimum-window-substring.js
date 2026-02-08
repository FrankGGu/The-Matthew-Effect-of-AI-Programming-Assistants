var minWindow = function(s, t) {
    if (!s || !t || s.length < t.length) return "";

    const tMap = {};
    for (let char of t) {
        tMap[char] = (tMap[char] || 0) + 1;
    }

    let left = 0;
    let right = 0;
    let minLen = Infinity;
    let minStart = 0;
    let matched = 0;

    const windowMap = {};

    while (right < s.length) {
        const rightChar = s[right];
        if (tMap[rightChar]) {
            windowMap[rightChar] = (windowMap[rightChar] || 0) + 1;
            if (windowMap[rightChar] === tMap[rightChar]) {
                matched++;
            }
        }

        while (matched === Object.keys(tMap).length) {
            if (right - left + 1 < minLen) {
                minLen = right - left + 1;
                minStart = left;
            }

            const leftChar = s[left];
            if (tMap[leftChar]) {
                windowMap[leftChar]--;
                if (windowMap[leftChar] < tMap[leftChar]) {
                    matched--;
                }
            }
            left++;
        }
        right++;
    }

    return minLen === Infinity ? "" : s.substring(minStart, minStart + minLen);
};