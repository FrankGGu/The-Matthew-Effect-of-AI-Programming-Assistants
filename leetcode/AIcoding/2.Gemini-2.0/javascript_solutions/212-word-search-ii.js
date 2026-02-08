var findWords = function(board, words) {
    const trie = {};
    for (const word of words) {
        let node = trie;
        for (const char of word) {
            if (!node[char]) {
                node[char] = {};
            }
            node = node[char];
        }
        node.word = word;
    }

    const rows = board.length;
    const cols = board[0].length;
    const result = new Set();

    function dfs(row, col, node) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || !node[board[row][col]]) {
            return;
        }

        const char = board[row][col];
        const nextNode = node[char];

        if (nextNode.word) {
            result.add(nextNode.word);
        }

        board[row][col] = '#'; // Mark as visited
        dfs(row + 1, col, nextNode);
        dfs(row - 1, col, nextNode);
        dfs(row, col + 1, nextNode);
        dfs(row, col - 1, nextNode);
        board[row][col] = char; // Backtrack
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            dfs(i, j, trie);
        }
    }

    return Array.from(result);
};