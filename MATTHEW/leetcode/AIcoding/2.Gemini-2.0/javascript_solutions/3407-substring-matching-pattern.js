var wordPatternMatch = function(pattern, s) {
    const map = new Map();
    const set = new Set();

    function backtrack(i, j) {
        if (i === pattern.length && j === s.length) {
            return true;
        }
        if (i === pattern.length || j === s.length) {
            return false;
        }

        const char = pattern[i];

        if (map.has(char)) {
            const word = map.get(char);
            if (s.startsWith(word, j)) {
                return backtrack(i + 1, j + word.length);
            } else {
                return false;
            }
        } else {
            for (let k = j + 1; k <= s.length; k++) {
                const word = s.substring(j, k);
                if (set.has(word)) {
                    continue;
                }
                map.set(char, word);
                set.add(word);
                if (backtrack(i + 1, k)) {
                    return true;
                }
                map.delete(char);
                set.delete(word);
            }
            return false;
        }
    }

    return backtrack(0, 0);
};