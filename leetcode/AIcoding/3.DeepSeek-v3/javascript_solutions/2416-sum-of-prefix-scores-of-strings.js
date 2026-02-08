var sumPrefixScores = function(words) {
    const trie = {};
    for (const word of words) {
        let node = trie;
        for (const ch of word) {
            if (!node[ch]) {
                node[ch] = { count: 0 };
            }
            node = node[ch];
            node.count++;
        }
    }

    const result = [];
    for (const word of words) {
        let score = 0;
        let node = trie;
        for (const ch of word) {
            node = node[ch];
            score += node.count;
        }
        result.push(score);
    }
    return result;
};