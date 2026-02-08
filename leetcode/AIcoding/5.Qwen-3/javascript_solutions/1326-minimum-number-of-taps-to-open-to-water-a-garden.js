function numberOfTaps(n) {
    const range = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        const left = Math.max(1, i - range[i]);
        const right = Math.min(n, i + range[i]);
        for (let j = left; j <= right; j++) {
            range[j] = Math.max(range[j], right);
        }
    }

    let res = 0;
    let end = 0;
    let nextEnd = 0;
    for (let i = 1; i <= n; i++) {
        if (i > end) {
            return -1;
        }
        nextEnd = Math.max(nextEnd, range[i]);
        if (i === end) {
            res++;
            end = nextEnd;
        }
    }
    return res;
}