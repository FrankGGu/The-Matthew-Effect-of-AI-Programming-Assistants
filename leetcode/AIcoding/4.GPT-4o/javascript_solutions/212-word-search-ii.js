class TrieNode {
    constructor() {
        this.children = {};
        this.isEnd = false;
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
    }

    insert(word) {
        let node = this.root;
        for (const char of word) {
            if (!node.children[char]) {
                node.children[char] = new TrieNode();
            }
            node = node.children[char];
        }
        node.isEnd = true;
    }
}

var findWords = function(board, words) {
    const trie = new Trie();
    for (const word of words) {
        trie.insert(word);
    }

    const res = new Set();
    const m = board.length;
    const n = board[0].length;

    const dfs = (i, j, node, path) => {
        if (node.isEnd) {
            res.add(path);
            node.isEnd = false; // avoid duplicate entries
        }

        const temp = board[i][j];
        board[i][j] = '#'; // mark visited
        for (const [x, y] of [[0, 1], [1, 0], [0, -1], [-1, 0]]) {
            const ni = i + x, nj = j + y;
            if (ni >= 0 && ni < m && nj >= 0 && nj < n && board[ni][nj] in node.children) {
                dfs(ni, nj, node.children[board[ni][nj]], path + board[ni][nj]);
            }
        }
        board[i][j] = temp; // unmark visited
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (board[i][j] in trie.root.children) {
                dfs(i, j, trie.root.children[board[i][j]], board[i][j]);
            }
        }
    }

    return Array.from(res);
};