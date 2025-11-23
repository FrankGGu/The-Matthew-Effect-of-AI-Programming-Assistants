function maxSpending(items) {
    let n = items.length;
    let m = items[0].length;
    let flat = [];
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            flat.push(items[i][j]);
        }
    }
    flat.sort((a, b) => a - b);
    let sum = 0;
    for (let i = 0; i < flat.length; i++) {
        sum += flat[i];
    }
    return sum;
}