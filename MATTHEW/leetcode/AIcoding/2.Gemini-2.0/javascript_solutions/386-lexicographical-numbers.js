var lexicalOrder = function(n) {
    const result = [];
    let current = 1;

    for (let i = 0; i < n; i++) {
        result.push(current);
        if (current * 10 <= n) {
            current *= 10;
        } else {
            if (current >= n) {
                current = Math.floor(current / 10);
            }
            current++;
            while (current % 10 === 0) {
                current = Math.floor(current / 10);
                current++;
            }
        }
    }

    return result;
};