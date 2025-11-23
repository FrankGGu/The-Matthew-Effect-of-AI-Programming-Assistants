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

    const result = [];
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    const dfs = (node, x, y) => {
        const char = board[x][y];
        const currNode = node.children[char];
        if (!currNode) return;

        if (currNode.word !== null) {
            result.push(currNode.word);
            currNode.word = null;
        }

        board[x][y] = '#';
        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < board.length && ny >= 0 && ny < board[0].length && board[nx][ny] !== '#') {
                dfs(currNode, nx, ny);
            }
        }
        board[x][y] = char;

        if (Object.keys(currNode.children).length === 0) {
            delete node.children[char];
        }
    };

    for (let i = 0; i < board.length; i++) {
        for (let j = 0; j < board[0].length; j++) {
            if (root.children[board[i][j]]) {
                dfs(root, i, j);
            }
        }
    }

    return result;
};