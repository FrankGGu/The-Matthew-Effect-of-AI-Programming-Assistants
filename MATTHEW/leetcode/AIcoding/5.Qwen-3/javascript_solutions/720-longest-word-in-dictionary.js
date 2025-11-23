var longestWord = function(words) {
    words.sort();
    const trie = {};
    let result = "";

    for (const word of words) {
        let node = trie;
        for (let i = 0; i < word.length; i++) {
            const char = word[i];
            if (!node[char]) {
                node[char] = {};
            }
            node = node[char];
        }
        node.isEnd = true;
    }

    function dfs(node, current) {
        if (Object.keys(node).length === 0 || !node.isEnd) {
            return current;
        }
        let max = current;
        for (const key in node) {
            if (key !== "isEnd") {
                const res = dfs(node[key], current + key);
                if (res.length > max.length) {
                    max = res;
                }
            }
        }
        return max;
    }

    return dfs(trie, "");
};