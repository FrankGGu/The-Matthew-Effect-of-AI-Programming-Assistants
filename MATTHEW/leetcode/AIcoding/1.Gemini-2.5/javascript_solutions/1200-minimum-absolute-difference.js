var minimumAbsoluteDifference = function(arr) {
    arr.sort((a, b) => a - b);

    let minDiff = Infinity;
    for (let i = 0; i < arr.length - 1; i++) {
        const currentDiff = arr[i + 1] - arr[i];
        if (currentDiff < minDiff) {
            minDiff = currentDiff;
        }
    }

    const result = [];
    for (let i = 0; i < arr.length - 1; i++) {
        if (arr[i + 1] - arr[i] === minDiff) {
            result.push([arr[i], arr[i + 1]]);
        }
    }

    return result;
};