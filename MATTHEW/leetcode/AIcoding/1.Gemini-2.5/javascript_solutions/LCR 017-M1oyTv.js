var minWindow = function(s, t) {
    if (t.length === 0) {
        return "";
    }

    const charCount = new Map();
    for (const char of t) {
        charCount.set(char, (charCount.get(char) || 0) + 1);
    }

    let left = 0;
    let minLen = Infinity;
    let minStart = 0;
    let matched = 0; // Number of characters in t that are matched in the current window

    for (let right = 0; right < s.length; right++) {
        const charR = s[right];
        if (charCount.has(charR)) {
            charCount.set(charR, charCount.get(charR) - 1);
            if (charCount.get(charR) >= 0) { // Only count if it's a needed character
                matched++;
            }
        }

        while (matched === t.length) {
            if (right - left + 1 < minLen) {
                minLen = right - left + 1;
                minStart = left;
            }

            const charL = s[left];
            if (charCount.has(charL)) {
                if (charCount.get(charL) >= 0) { // Only decrement if it was a needed character
                    matched--;
                }
                charCount.set(charL, charCount.get(charL) + 1);
            }
            left++;
        }
    }

    return minLen === Infinity ? "" : s.substring(minStart, minStart + minLen);
};