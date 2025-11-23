var canFormArray = function(arr, pieces) {
    const pieceMap = new Map();
    for (const piece of pieces) {
        pieceMap.set(piece[0], piece);
    }

    let i = 0;
    while (i < arr.length) {
        if (!pieceMap.has(arr[i])) {
            return false;
        }
        const piece = pieceMap.get(arr[i]);
        for (let j = 0; j < piece.length; j++) {
            if (arr[i] !== piece[j]) {
                return false;
            }
            i++;
        }
    }

    return true;
};