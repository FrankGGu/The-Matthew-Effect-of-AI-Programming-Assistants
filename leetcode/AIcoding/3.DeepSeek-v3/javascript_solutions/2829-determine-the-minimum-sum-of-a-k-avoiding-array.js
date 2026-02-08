var minimumSum = function(n, k) {
    const set = new Set();
    let sum = 0;
    let num = 1;
    for (let i = 0; i < n; i++) {
        while (set.has(k - num)) {
            num++;
        }
        set.add(num);
        sum += num;
        num++;
    }
    return sum;
};