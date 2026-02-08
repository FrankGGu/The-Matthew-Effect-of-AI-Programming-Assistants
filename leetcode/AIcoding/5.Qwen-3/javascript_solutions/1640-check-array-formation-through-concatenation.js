function canFormArray(arr, pieces) {
    const map = new Map();
    for (const piece of pieces) {
        map.set(piece[0], piece);
    }

    let i = 0;
    while (i < arr.length) {
        if (!map.has(arr[i])) {
            return false;
        }
        const piece = map.get(arr[i]);
        for (const num of piece) {
            if (arr[i] !== num) {
                return false;
            }
            i++;
        }
    }
    return true;
}