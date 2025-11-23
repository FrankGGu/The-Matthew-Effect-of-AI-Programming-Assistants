function countWays(ranges) {
    ranges.sort((a, b) => a[0] - b[0]);
    let result = 1;
    let prevEnd = -1;
    for (const [start, end] of ranges) {
        if (start > prevEnd) {
            result = (result * 2) % (10 ** 9 + 7);
            prevEnd = end;
        }
    }
    return result;
}