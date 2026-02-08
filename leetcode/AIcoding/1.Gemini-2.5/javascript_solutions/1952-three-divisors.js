var isThree = function(n) {
    if (n < 4) {
        return false;
    }

    const root = Math.sqrt(n);

    if (root % 1 !== 0) {
        return false;
    }

    const p = root;

    if (p <= 1) {
        return false;
    }

    for (let i = 2; i * i <= p; i++) {
        if (p % i === 0) {
            return false;
        }
    }

    return true;
};