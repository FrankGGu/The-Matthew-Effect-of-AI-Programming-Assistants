function maxSatisfied(p, c) {
    let n = p.length;
    let total = 0;
    for (let i = 0; i < n; i++) {
        if (p[i] === 0) {
            total++;
        }
    }
    let max = total;
    let left = 0;
    for (let right = 0; right < n; right++) {
        if (p[right] === 1) {
            total++;
        }
        while (p[right] === 1 && p[left] === 1) {
            if (p[left] === 1) {
                total--;
            }
            left++;
        }
        if (p[right] === 1 && p[left] === 0) {
            max = Math.max(max, total);
        }
    }
    return max;
}