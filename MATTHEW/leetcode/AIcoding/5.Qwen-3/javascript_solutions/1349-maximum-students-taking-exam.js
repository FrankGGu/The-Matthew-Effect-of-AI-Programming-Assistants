function maxStudents(seat) {
    const m = seat.length;
    const n = seat[0].length;
    const dp = new Array(m).fill(0).map(() => new Array(n).fill(0));
    const prev = new Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        const curr = new Array(n).fill(0);
        for (let j = 0; j < n; j++) {
            if (seat[i][j] === '#') continue;
            let max = 0;
            for (let k = 0; k < n; k++) {
                if (seat[i][k] === '#') continue;
                if (k === j) continue;
                if (Math.abs(k - j) > 1) {
                    max = Math.max(max, prev[k]);
                }
            }
            curr[j] = max + 1;
        }
        prev.splice(0, n, ...curr);
    }

    return Math.max(...prev);
}