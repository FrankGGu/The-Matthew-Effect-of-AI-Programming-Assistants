function intersectionSizeTwo(intervals) {
    intervals.sort((a, b) => a[1] - b[1]);
    let count = 0;
    let end = [-1, -1];

    for (const [start, finish] of intervals) {
        if (end[1] < start) {
            count += 2;
            end = [finish - 1, finish];
        } else if (end[0] < start) {
            count += 1;
            end[0] = finish - 1;
        }
    }
    return count;
}