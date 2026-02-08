var minimumEffort = function(tasks) {
    tasks.sort((a, b) => (b[1] - b[0]) - (a[1] - a[0]));
    let res = 0;
    let curr = 0;
    for (const [cost, min] of tasks) {
        if (curr < min) {
            res += min - curr;
            curr = min - cost;
        } else {
            curr -= cost;
        }
    }
    return res;
};