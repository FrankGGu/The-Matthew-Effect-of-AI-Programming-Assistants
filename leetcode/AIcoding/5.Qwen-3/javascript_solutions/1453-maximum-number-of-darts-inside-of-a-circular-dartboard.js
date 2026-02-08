function maxNumberOfDarts(darts) {
    const n = darts.length;
    if (n <= 2) return n;

    let max = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const [x1, y1] = darts[i];
            const [x2, y2] = darts[j];
            const cx = (x1 + x2) / 2;
            const cy = (y1 + y2) / 2;
            const r2 = (x1 - x2) ** 2 + (y1 - y2) ** 2;

            let count = 2;

            for (let k = 0; k < n; k++) {
                if (k === i || k === j) continue;
                const [x, y] = darts[k];
                const dx = x - cx;
                const dy = y - cy;
                const dist2 = dx * dx + dy * dy;
                if (Math.abs(dist2 - r2) < 1e-8) {
                    count++;
                }
            }

            max = Math.max(max, count);
        }
    }

    return max;
}