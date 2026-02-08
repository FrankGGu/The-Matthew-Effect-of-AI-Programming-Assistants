var minimumRemoval = function(beans) {
    beans.sort((a, b) => a - b);
    let n = beans.length;
    let totalSum = beans.reduce((sum, bean) => sum + bean, 0);
    let minRemoval = Infinity;

    for (let i = 0; i < n; i++) {
        let removal = totalSum - beans[i] * (n - i);
        minRemoval = Math.min(minRemoval, removal);
    }

    return minRemoval;
};