var smallestDivisibleDigitProduct = function(n) {
    const digits = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    let queue = [''];
    let result = -1;

    while (queue.length > 0) {
        const current = queue.shift();
        for (const d of digits) {
            const next = current + d.toString();
            const num = parseInt(next, 10);
            if (num > 0 && num % n === 0) {
                const product = next.split('').reduce((acc, val) => acc * parseInt(val, 10), 1);
                if (result === -1 || product < result) {
                    result = product;
                }
            }
            if (next.length < 10) { // Prevent too large numbers
                queue.push(next);
            }
        }
    }

    return result;
};