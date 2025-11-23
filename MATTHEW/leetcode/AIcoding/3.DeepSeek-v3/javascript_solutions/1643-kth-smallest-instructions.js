var kthSmallestPath = function(destination, k) {
    const [v, h] = destination;
    let res = [];
    let remainingV = v;
    let remainingH = h;
    for (let i = 0; i < h + v; i++) {
        const combinations = getCombinations(remainingH - 1 + remainingV, remainingV);
        if (k <= combinations) {
            res.push('H');
            remainingH--;
        } else {
            res.push('V');
            k -= combinations;
            remainingV--;
        }
    }
    return res.join('');
};

function getCombinations(n, k) {
    if (k > n) return 0;
    if (k === 0 || k === n) return 1;
    k = Math.min(k, n - k);
    let res = 1;
    for (let i = 1; i <= k; i++) {
        res = res * (n - k + i) / i;
    }
    return res;
}