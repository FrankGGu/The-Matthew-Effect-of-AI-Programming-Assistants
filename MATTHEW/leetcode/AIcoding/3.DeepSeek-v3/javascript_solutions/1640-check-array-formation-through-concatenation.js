var canFormArray = function(arr, pieces) {
    const map = new Map();
    for (const piece of pieces) {
        map.set(piece[0], piece);
    }

    let i = 0;
    while (i < arr.length) {
        const num = arr[i];
        if (!map.has(num)) {
            return false;
        }
        const piece = map.get(num);
        for (let j = 0; j < piece.length; j++) {
            if (arr[i] !== piece[j]) {
                return false;
            }
            i++;
        }
    }
    return true;
};