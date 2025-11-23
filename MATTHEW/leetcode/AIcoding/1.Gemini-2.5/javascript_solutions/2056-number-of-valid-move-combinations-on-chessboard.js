var numberOfValidMoveCombinations = function(pieces, positions) {
    let ans = 0;
    const N = pieces.length;
    const BOARD_SIZE = 8;

    function parsePos(s) {
        const col = s.charCodeAt(0) - 'a'.charCodeAt(0);
        const row = parseInt(s[1]) - 1;
        return [row, col];
    }

    function isValid(r, c) {
        return r >= 0 && r < BOARD_SIZE && c >= 0 && c < BOARD_SIZE;
    }

    function getPieceMoves(pieceType, startR, startC, allInitialPositionsSet) {
        const moves = new Set();
        moves.add(`${startR},${startC}`);

        const directions = [];
        if (pieceType === "rook" || pieceType === "queen") {
            directions.push([0, 1], [0, -1], [1, 0], [-1, 0]);
        }
        if (pieceType === "bishop" || pieceType === "queen") {
            directions.push([1, 1], [1, -1], [-1, 1], [-1, -1]);
        }

        for (const [dr, dc] of directions) {
            let nr = startR + dr;
            let nc = startC + dc;
            while (isValid(nr, nc)) {
                const currentPosStr = `${nr},${nc}`;
                if (allInitialPositionsSet.has(currentPosStr)) {
                    break;
                }
                moves.add(currentPosStr);
                nr += dr;
                nc += dc;
            }
        }
        return Array.from(moves);
    }

    const initialParsedPositions = positions.map(parsePos);
    const allInitialPositionsSet = new Set(initialParsedPositions.map(pos => `${pos[0]},${pos[1]}`));

    const allPieceMovesList = [];
    for (let i = 0; i < N; i++) {
        const [r, c] = initialParsedPositions[i];
        allPieceMovesList.push(getPieceMoves(pieces[i], r, c, allInitialPositionsSet));
    }

    function dfs(k, currentSelectedMovesSet) {
        if (k === N) {
            ans++;
            return;
        }

        for (const moveStr of allPieceMovesList[k]) {
            if (!currentSelectedMovesSet.has(moveStr)) {
                currentSelectedMovesSet.add(moveStr);
                dfs(k + 1, currentSelectedMovesSet);
                currentSelectedMovesSet.delete(moveStr);
            }
        }
    }

    dfs(0, new Set());
    return ans;
};