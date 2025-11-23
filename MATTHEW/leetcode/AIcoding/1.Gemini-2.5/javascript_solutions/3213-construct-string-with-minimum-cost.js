class TrieNode {
    constructor() {
        this.children = new Map();
        this.minCost = Infinity;
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
    }

    insert(word, cost) {
        let node = this.root;
        for (const char of word) {
            if (!node.children.has(char)) {
                node.children.set(char, new TrieNode());
            }
            node = node.children.get(char);
        }
        node.minCost = Math.min(node.minCost, cost);
    }
}

function constructStringWithMinimumCost(target, words, costs) {
    const trie = new Trie();
    for (let i = 0; i < words.length; i++) {
        trie.insert(words[i], costs[i]);
    }

    const n = target.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        if (dp[i] === Infinity) {
            continue;
        }

        let node = trie.root;
        for (let j = i; j < n; j++) {
            const char = target[j];

            if (!node.children.has(char)) {
                break;
            }

            node = node.children.get(char);

            if (node.minCost !== Infinity) {
                dp[j + 1] = Math.min(dp[j + 1], dp[i] + node.minCost);
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
}