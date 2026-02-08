var distributeCandies = function(n, limit) {
    let count = 0;
    for (let a = 0; a <= Math.min(n, limit); a++) {
        let remaining = n - a;
        let minB = Math.max(0, remaining - limit);
        let maxB = Math.min(remaining, limit);
        if (minB <= maxB) {
            count += maxB - minB + 1;
        }
    }
    return count;
};