class TrieNode {
    constructor() {
        this.children = {};
        this.word = null;
    }
}

var findWords = function(board, words) {
    const root = new TrieNode();
    for (const word of words) {
        let node = root;
        for (const char of word) {
            if (!node.children[char]) {
                node.children[char] = new TrieNode();
            }
            node = node.children[char];
        }
        node.word = word;
    }

    const rows = board.length;
    const cols = board[0].length;
    const result = new Set();

    function dfs(r, c, node) {
        if (r < 0 || r >= rows || c < 0 || c >= cols) {
            return;
        }

        const char = board[r][c];

        if (!node.children[char]) {
            return;
        }

        node = node.children[char];

        if (node.word !== null) {
            result.add(node.word);
            node.word = null;
        }

        board[r][c] = '#';

        dfs(r + 1, c, node);
        dfs(r - 1, c, node);
        dfs(r, c + 1, node);
        dfs(r, c - 1, node);

        board[r][c] = char;
    }

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            dfs(r, c, root);
        }
    }

    return Array.from(result);
};