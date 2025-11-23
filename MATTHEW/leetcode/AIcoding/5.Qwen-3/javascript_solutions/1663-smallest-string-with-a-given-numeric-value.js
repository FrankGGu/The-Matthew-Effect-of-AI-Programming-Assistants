function getSmallestString(n, k) {
    const res = new Array(n).fill('a');
    k -= n;
    for (let i = n - 1; i >= 0 && k > 0; i--) {
        const add = Math.min(k, 25);
        res[i] = String.fromCharCode('a'.charCodeAt(0) + add);
        k -= add;
    }
    return res.join('');
}