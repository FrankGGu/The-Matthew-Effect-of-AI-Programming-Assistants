class TrieNode {
    constructor() {
        this.children = new Map();
        this.sum = 0;
    }
}

class MapSum {
    constructor() {
        this.root = new TrieNode();
        this.keyValues = new Map();
    }

    insert(key, val) {
        const oldVal = this.keyValues.get(key) || 0;
        const delta = val - oldVal;

        this.keyValues.set(key, val);

        let curr = this.root;
        for (const char of key) {
            if (!curr.children.has(char)) {
                curr.children.set(char, new TrieNode());
            }
            curr = curr.children.get(char);
            curr.sum += delta;
        }
    }

    sum(prefix) {
        let curr = this.root;
        for (const char of prefix) {
            if (!curr.children.has(char)) {
                return 0;
            }
            curr = curr.children.get(char);
        }
        return curr.sum;
    }
}