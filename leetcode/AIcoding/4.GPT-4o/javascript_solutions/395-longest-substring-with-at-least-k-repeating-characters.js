var longestSubstring = function(s, k) {
    const countChars = (str) => {
        const count = {};
        for (const char of str) {
            count[char] = (count[char] || 0) + 1;
        }
        return count;
    };

    const longest = (start, end) => {
        if (end < k) return 0;
        const count = countChars(s.substring(start, end));
        for (let i = start; i < end; i++) {
            if (count[s[i]] < k) {
                const nextStart = i + 1;
                while (i + 1 < end && s[i + 1] === s[i]) i++;
                return Math.max(longest(start, nextStart), longest(nextStart, end));
            }
        }
        return end - start;
    };

    return longest(0, s.length);
};