var sumPrefixScores = function(words) {
    const trie = {};

    for (const word of words) {
        let node = trie;
        for (const char of word) {
            if (!node[char]) {
                node[char] = { count: 0 };
            }
            node[char].count++;
            node = node[char];
        }
    }

    const result = [];
    for (const word of words) {
        let score = 0;
        let node = trie;
        for (const char of word) {
            score += node[char].count;
            node = node[char];
        }
        result.push(score);
    }

    return result;
};