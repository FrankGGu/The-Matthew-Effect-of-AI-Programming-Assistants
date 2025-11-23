function longestValidSubstring(s) {
    let maxLength = 0;
    let left = 0;
    const map = new Map();

    for (let right = 0; right < s.length; right++) {
        const char = s[right];
        if (char === ')' || char === ']') {
            const pair = char === ')' ? '(' : '[';
            if (map.has(pair)) {
                left = Math.max(left, map.get(pair) + 1);
            }
        }
        map.set(char, right);
        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
}