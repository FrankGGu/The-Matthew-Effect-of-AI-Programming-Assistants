var replaceWords = function(dictionary, sentence) {
    const words = sentence.split(" ");
    const trie = {};

    for (const word of dictionary) {
        let node = trie;
        for (const char of word) {
            if (!node[char]) {
                node[char] = {};
            }
            node = node[char];
        }
        node.isWord = true;
    }

    for (let i = 0; i < words.length; i++) {
        let word = words[i];
        let node = trie;
        let prefix = "";
        for (let j = 0; j < word.length; j++) {
            const char = word[j];
            if (node[char]) {
                prefix += char;
                node = node[char];
                if (node.isWord) {
                    words[i] = prefix;
                    break;
                }
            } else {
                break;
            }
        }
    }

    return words.join(" ");
};