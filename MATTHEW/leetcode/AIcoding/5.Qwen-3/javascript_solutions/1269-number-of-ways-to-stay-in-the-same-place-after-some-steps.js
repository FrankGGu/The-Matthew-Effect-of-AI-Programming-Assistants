var numWays = function(n, k) {
    if (n === 0) return 1;
    if (k === 0) return 0;

    let prev = 1;
    let curr = k;

    for (let i = 2; i <= n; i++) {
        let temp = curr;
        curr = (curr + prev) * (k - 1);
        prev = temp;
    }

    return curr;
};