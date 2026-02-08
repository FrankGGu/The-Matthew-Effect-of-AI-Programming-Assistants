var minimumRemoval = function(beans) {
    beans.sort((a, b) => a - b);
    const n = beans.length;
    let total = beans.reduce((sum, num) => sum + num, 0);
    let minRemoval = Infinity;

    for (let i = 0; i < n; i++) {
        const current = total - beans[i] * (n - i);
        if (current < minRemoval) {
            minRemoval = current;
        }
    }

    return minRemoval;
};