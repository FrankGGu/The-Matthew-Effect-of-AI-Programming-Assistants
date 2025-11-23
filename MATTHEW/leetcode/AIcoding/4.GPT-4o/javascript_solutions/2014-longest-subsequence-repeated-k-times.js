function longestSubsequenceRepeatedK(s, k) {
    const freq = new Map();
    for (const char of s) {
        freq.set(char, (freq.get(char) || 0) + 1);
    }

    const result = [];
    for (const [char, count] of freq) {
        if (count >= k) {
            result.push(char.repeat(k));
        }
    }

    return result.length > 0 ? result.join('') : "";
}