var maximizeTowerHeights = function(arr) {
    arr.sort((a, b) => a - b);
    let n = arr.length;
    let res = 0;
    let prev = 0;

    for (let i = 0; i < n; i++) {
        let curr = arr[i];
        if (i === 0) {
            prev = curr;
        } else {
            if (curr <= prev) {
                curr = prev + 1;
            }
            prev = curr;
        }
        res += curr;
    }

    return res;
};