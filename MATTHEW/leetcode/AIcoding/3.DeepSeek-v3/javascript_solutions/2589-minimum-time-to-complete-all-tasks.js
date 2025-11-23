var findMinimumTime = function(tasks) {
    tasks.sort((a, b) => a[1] - b[1]);
    const used = new Array(2001).fill(false);
    let res = 0;

    for (const [start, end, duration] of tasks) {
        let remaining = duration;
        for (let i = start; i <= end; i++) {
            if (used[i]) {
                remaining--;
            }
        }
        for (let i = end; remaining > 0; i--) {
            if (!used[i]) {
                used[i] = true;
                remaining--;
                res++;
            }
        }
    }

    return res;
};