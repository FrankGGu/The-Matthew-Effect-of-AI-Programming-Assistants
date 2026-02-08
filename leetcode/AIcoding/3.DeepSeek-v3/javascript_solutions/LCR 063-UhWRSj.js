var replaceWords = function(dictionary, sentence) {
    const trie = {};
    for (const word of dictionary) {
        let node = trie;
        for (const char of word) {
            if (!node[char]) {
                node[char] = {};
            }
            node = node[char];
        }
        node.isEnd = true;
    }

    const words = sentence.split(' ');
    for (let i = 0; i < words.length; i++) {
        let node = trie;
        let prefix = '';
        for (const char of words[i]) {
            if (node.isEnd) {
                words[i] = prefix;
                break;
            }
            if (!node[char]) {
                break;
            }
            prefix += char;
            node = node[char];
        }
        if (node.isEnd) {
            words[i] = prefix;
        }
    }
    return words.join(' ');
};