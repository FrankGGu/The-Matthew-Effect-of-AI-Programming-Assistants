var maxTurbulenceSize = function(arr) {
    const n = arr.length;
    if (n < 2) {
        return n;
    }

    let maxLen = 1;
    let up = 1;
    let down = 1;

    for (let i = 1; i < n; i++) {
        if (arr[i] > arr[i - 1]) {
            up = down + 1;
            down = 1;
        } else if (arr[i] < arr[i - 1]) {
            down = up + 1;
            up = 1;
        } else {
            up = 1;
            down = 1;
        }
        maxLen = Math.max(maxLen, up, down);
    }

    return maxLen;
};