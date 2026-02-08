class TrieNode {
    constructor() {
        this.children = new Map();
        this.isEndOfWord = false;
    }
}

class StreamChecker {
    constructor(words) {
        this.root = new TrieNode();
        this.maxWordLength = 0;

        for (const word of words) {
            this.maxWordLength = Math.max(this.maxWordLength, word.length);
            let curr = this.root;
            for (let i = word.length - 1; i >= 0; i--) {
                const char = word[i];
                if (!curr.children.has(char)) {
                    curr.children.set(char, new TrieNode());
                }
                curr = curr.children.get(char);
            }
            curr.isEndOfWord = true;
        }

        this.activeTrieNodes = [this.root];
    }

    query(letter) {
        const nextActiveTrieNodes = [];
        let foundMatch = false;

        for (const node of this.activeTrieNodes) {
            if (node.children.has(letter)) {
                const nextNode = node.children.get(letter);
                nextActiveTrieNodes.push(nextNode);
                if (nextNode.isEndOfWord) {
                    foundMatch = true;
                }
            }
        }

        nextActiveTrieNodes.push(this.root);

        this.activeTrieNodes = nextActiveTrieNodes;

        return foundMatch;
    }
}