function minWindow(s, t) {
    if (t.length === 0) {
        return "";
    }

    const mapT = {};
    for (const char of t) {
        mapT[char] = (mapT[char] || 0) + 1;
    }

    let windowStart = 0;
    let matchedCount = 0;
    const requiredUniqueChars = Object.keys(mapT).length;

    let minLength = Infinity;
    let minStart = 0;

    const windowMap = {};

    for (let windowEnd = 0; windowEnd < s.length; windowEnd++) {
        const charEnd = s[windowEnd];

        if (charEnd in mapT) {
            windowMap[charEnd] = (windowMap[charEnd] || 0) + 1;
            if (windowMap[charEnd] === mapT[charEnd]) {
                matchedCount++;
            }
        }

        while (matchedCount === requiredUniqueChars) {
            if (windowEnd - windowStart + 1 < minLength) {
                minLength = windowEnd - windowStart + 1;
                minStart = windowStart;
            }

            const charStart = s[windowStart];
            windowStart++;

            if (charStart in mapT) {
                if (windowMap[charStart] === mapT[charStart]) {
                    matchedCount--;
                }
                windowMap[charStart]--;
            }
        }
    }

    if (minLength === Infinity) {
        return "";
    }

    return s.substring(minStart, minStart + minLength);
}