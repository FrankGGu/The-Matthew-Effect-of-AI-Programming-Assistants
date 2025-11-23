function mostVisited(n, rounds) {
    const count = new Array(n).fill(0);
    const m = rounds.length;
    for (let i = 0; i < m - 1; i++) {
        const start = rounds[i];
        const end = rounds[i + 1];
        if (start <= end) {
            for (let j = start; j <= end; j++) {
                count[j - 1]++;
            }
        } else {
            for (let j = start; j <= n; j++) {
                count[j - 1]++;
            }
            for (let j = 1; j <= end; j++) {
                count[j - 1]++;
            }
        }
    }
    let max = -1;
    let result = [];
    for (let i = 0; i < n; i++) {
        if (count[i] > max) {
            max = count[i];
            result = [i + 1];
        } else if (count[i] === max) {
            result.push(i + 1);
        }
    }
    return result;
}