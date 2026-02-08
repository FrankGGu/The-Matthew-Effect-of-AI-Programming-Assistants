function canBeSorted(arr) {
    const sorted = [...arr].sort((a, b) => a - b);
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] !== sorted[i] && arr[i] !== sorted[arr.length - 1 - i]) {
            return false;
        }
    }
    return true;
}