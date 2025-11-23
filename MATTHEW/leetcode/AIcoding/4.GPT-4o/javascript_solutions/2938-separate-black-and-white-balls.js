function sortBalls(arr) {
    let whiteIndex = 0;
    let blackIndex = arr.length - 1;

    while (whiteIndex < blackIndex) {
        while (arr[whiteIndex] === 0) {
            whiteIndex++;
        }
        while (arr[blackIndex] === 1) {
            blackIndex--;
        }
        if (whiteIndex < blackIndex) {
            [arr[whiteIndex], arr[blackIndex]] = [arr[blackIndex], arr[whiteIndex]];
        }
    }
    return arr;
}