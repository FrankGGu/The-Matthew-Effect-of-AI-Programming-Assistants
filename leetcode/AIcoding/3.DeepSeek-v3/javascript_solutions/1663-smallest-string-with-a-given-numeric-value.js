var getSmallestString = function(n, k) {
    let res = new Array(n).fill('a');
    k -= n;
    let i = n - 1;
    while (k > 0) {
        let add = Math.min(k, 25);
        res[i] = String.fromCharCode(res[i].charCodeAt(0) + add);
        k -= add;
        i--;
    }
    return res.join('');
};