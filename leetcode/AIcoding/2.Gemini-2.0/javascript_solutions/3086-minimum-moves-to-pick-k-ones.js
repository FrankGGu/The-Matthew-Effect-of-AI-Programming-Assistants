var minMoves = function(arr, k) {
    const ones = [];
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === 1) {
            ones.push(i);
        }
    }

    if (ones.length < k) {
        return 0;
    }

    let prefixSum = new Array(ones.length + 1).fill(0);
    for (let i = 0; i < ones.length; i++) {
        prefixSum[i + 1] = prefixSum[i] + ones[i];
    }

    let minMoves = Infinity;
    for (let i = 0; i <= ones.length - k; i++) {
        let mid = Math.floor((i + i + k - 1) / 2);
        let moves = 0;
        let leftCount = mid - i;
        let rightCount = i + k - 1 - mid;

        moves = (ones[mid] * leftCount - (prefixSum[mid] - prefixSum[i])) +
                (prefixSum[i + k] - prefixSum[mid + 1] - ones[mid] * rightCount) -
                ((leftCount * (leftCount + 1)) / 2) - ((rightCount * (rightCount + 1)) / 2);

        minMoves = Math.min(minMoves, moves);
    }

    return minMoves;
};