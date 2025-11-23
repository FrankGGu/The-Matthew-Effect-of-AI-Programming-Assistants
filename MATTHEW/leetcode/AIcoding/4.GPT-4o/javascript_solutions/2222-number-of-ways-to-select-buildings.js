function countWays(lands) {
    const n = lands.length;
    let total = 0, cnt = 0;

    for (let i = 0; i < n; i++) {
        if (lands[i] === 1) cnt++;
    }

    if (cnt < 3) return 0;

    let left = 0, right = 0;
    for (let i = 0; i < n; i++) {
        if (lands[i] === 1) left++;
        if (lands[i] === 1) right++;
        if (lands[i] === 0 && left > 0) {
            total += left * (cnt - left);
            if (cnt - left < 0) break;
        }
    }

    return total;
}