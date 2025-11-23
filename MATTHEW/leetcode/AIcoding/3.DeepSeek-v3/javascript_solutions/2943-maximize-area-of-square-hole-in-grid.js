var maximizeSquareHoleArea = function(n, m, hBars, vBars) {
    const maxConsecutive = (arr) => {
        arr.sort((a, b) => a - b);
        let max = 1, current = 1;
        for (let i = 1; i < arr.length; i++) {
            if (arr[i] === arr[i - 1] + 1) {
                current++;
                max = Math.max(max, current);
            } else {
                current = 1;
            }
        }
        return max + 1;
    };

    const hMax = maxConsecutive(hBars);
    const vMax = maxConsecutive(vBars);
    const side = Math.min(hMax, vMax);
    return side * side;
};