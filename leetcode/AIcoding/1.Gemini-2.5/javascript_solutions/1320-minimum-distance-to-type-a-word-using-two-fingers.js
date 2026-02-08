var minimumDistance = function(word) {
    const word_len = word.length;
    const word_char_indices = new Array(word_len);
    for (let i = 0; i < word_len; i++) {
        word_char_indices[i] = word.charCodeAt(i) - 65;
    }

    const memo = Array(word_len).fill(0).map(() => 
        Array(27).fill(0).map(() => 
            Array(27).fill(undefined)
        )
    );

    const getCharPos = (char_idx) => {
        const row = Math.floor(char_idx / 6);
        const col = char_idx % 6;
        return { row, col };
    };

    const manhattanDistance = (char_idx1, char_idx2) => {
        const p1 = getCharPos(char_idx1);
        const p2 = getCharPos(char_idx2);
        return Math.abs(p1.row - p2.row) + Math.abs(p1.col - p2.col);
    };

    const solve = (idx, f1_pos_idx, f2_pos_idx) => {
        if (idx === word_len) {
            return 0;
        }

        if (memo[idx][f1_pos_idx][f2_pos_idx] !== undefined) {
            return memo[idx][f1_pos_idx][f2_pos_idx];
        }

        const target_char_idx = word_char_indices[idx];

        let cost1 = 0;
        if (f1_pos_idx !== 26) {
            cost1 = manhattanDistance(f1_pos_idx, target_char_idx);
        }
        const res1 = cost1 + solve(idx + 1, target_char_idx, f2_pos_idx);

        let cost2 = 0;
        if (f2_pos_idx !== 26) {
            cost2 = manhattanDistance(f2_pos_idx, target_char_idx);
        }
        const res2 = cost2 + solve(idx + 1, f1_pos_idx, target_char_idx);

        memo[idx][f1_pos_idx][f2_pos_idx] = Math.min(res1, res2);
        return memo[idx][f1_pos_idx][f2_pos_idx];
    };

    return solve(0, 26, 26);
};