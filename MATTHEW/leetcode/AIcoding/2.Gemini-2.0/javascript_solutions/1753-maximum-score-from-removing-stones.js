var maximumScore = function(a, b, c) {
    const arr = [a, b, c].sort((x, y) => x - y);
    let count = 0;

    while (arr[1] > 0) {
        arr[2]--;
        arr[1]--;
        count++;
        arr.sort((x, y) => x - y);
    }

    return count;
};