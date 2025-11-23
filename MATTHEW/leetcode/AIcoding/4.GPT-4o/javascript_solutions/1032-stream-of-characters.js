class StreamChecker {
    constructor(words) {
        this.trie = {};
        this.stream = [];
        for (const word of words) {
            let node = this.trie;
            for (let i = word.length - 1; i >= 0; i--) {
                if (!node[word[i]]) {
                    node[word[i]] = {};
                }
                node = node[word[i]];
            }
            node.isEnd = true;
        }
    }

    query(letter) {
        this.stream.push(letter);
        let node = this.trie;
        for (let i = this.stream.length - 1; i >= 0; i--) {
            if (!node[this.stream[i]]) {
                return false;
            }
            node = node[this.stream[i]];
            if (node.isEnd) {
                return true;
            }
        }
        return false;
    }
}