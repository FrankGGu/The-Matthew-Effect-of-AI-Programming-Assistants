function fallingSquares(positions) {
    const intervals = [];
    const res = [];

    for (const [left, right] of positions) {
        let newTop = 0;
        for (const [l, r, h] of intervals) {
            if (left < r && l < right) {
                newTop = Math.max(newTop, h);
            }
        }
        intervals.push([left, right, newTop + (right - left)]);
        res.push(newTop + (right - left));
    }

    return res;
}