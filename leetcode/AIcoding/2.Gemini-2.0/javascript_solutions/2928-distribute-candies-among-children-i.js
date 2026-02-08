var distributeCandies = function(n, limit) {
    let count = 0;
    for (let i = 0; i <= Math.min(n, limit); i++) {
        for (let j = 0; j <= Math.min(n - i, limit); j++) {
            let k = n - i - j;
            if (k >= 0 && k <= limit) {
                count++;
            }
        }
    }
    return count;
};