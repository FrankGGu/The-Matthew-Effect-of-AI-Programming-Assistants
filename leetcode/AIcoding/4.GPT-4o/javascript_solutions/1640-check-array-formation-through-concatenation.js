function canFormArray(arr, pieces) {
    const map = new Map();
    for (const piece of pieces) {
        map.set(piece[0], piece);
    }

    const result = [];
    for (let i = 0; i < arr.length;) {
        if (!map.has(arr[i])) return false;
        const piece = map.get(arr[i]);
        result.push(...piece);
        i += piece.length;
    }

    return result.length === arr.length;
}