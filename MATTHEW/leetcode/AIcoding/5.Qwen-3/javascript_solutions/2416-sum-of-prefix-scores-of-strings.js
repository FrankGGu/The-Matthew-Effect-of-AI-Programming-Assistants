function sumPrefixScores(strings) {
    const trie = {};
    let maxLen = 0;

    for (const str of strings) {
        let node = trie;
        for (const ch of str) {
            if (!node[ch]) node[ch] = {};
            node = node[ch];
            node.count = (node.count || 0) + 1;
        }
        maxLen = Math.max(maxLen, str.length);
    }

    const result = new Array(strings.length).fill(0);

    for (let i = 0; i < strings.length; i++) {
        let node = trie;
        let score = 0;
        for (const ch of strings[i]) {
            node = node[ch];
            score += node.count;
        }
        result[i] = score;
    }

    return result;
}