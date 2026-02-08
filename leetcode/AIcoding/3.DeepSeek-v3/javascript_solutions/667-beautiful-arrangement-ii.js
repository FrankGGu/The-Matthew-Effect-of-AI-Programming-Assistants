var constructArray = function(n, k) {
    let res = [];
    let left = 1, right = n;
    for (let i = 0; i < n; i++) {
        if (k > 1) {
            res.push(k % 2 !== 0 ? left++ : right--);
            k--;
        } else {
            res.push(left++);
        }
    }
    return res;
};