var canFormArray = function(arr, pieces) {
    const pieceMap = new Map();
    for (const piece of pieces) {
        pieceMap.set(piece[0], piece);
    }

    let i = 0;
    while (i < arr.length) {
        const currentNum = arr[i];
        if (!pieceMap.has(currentNum)) {
            return false;
        }

        const piece = pieceMap.get(currentNum);
        for (let j = 0; j < piece.length; j++) {
            if (arr[i + j] !== piece[j]) {
                return false;
            }
        }
        i += piece.length;
    }

    return true;
};