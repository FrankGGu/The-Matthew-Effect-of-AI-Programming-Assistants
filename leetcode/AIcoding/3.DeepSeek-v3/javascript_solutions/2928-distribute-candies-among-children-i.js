var distributeCandies = function(n, limit) {
    let count = 0;
    for (let a = 0; a <= limit; a++) {
        for (let b = 0; b <= limit; b++) {
            let c = n - a - b;
            if (c >= 0 && c <= limit) {
                count++;
            }
        }
    }
    return count;
};