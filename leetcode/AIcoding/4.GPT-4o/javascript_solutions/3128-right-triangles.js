function rightTriangles(n) {
    let count = 0;
    for (let a = 1; a < n; a++) {
        for (let b = a; b < n; b++) {
            let c = Math.sqrt(a * a + b * b);
            if (c % 1 === 0 && c < n) {
                count++;
            }
        }
    }
    return count;
}