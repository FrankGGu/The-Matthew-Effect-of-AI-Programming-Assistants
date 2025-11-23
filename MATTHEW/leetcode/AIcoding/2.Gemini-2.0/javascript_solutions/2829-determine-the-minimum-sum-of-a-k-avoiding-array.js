var minimumSum = function(n, k) {
    let sum = 0;
    let count = 0;
    let num = 1;
    let used = new Set();

    while (count < n) {
        if (!used.has(num)) {
            sum += num;
            count++;
            used.add(k - num);
        }
        num++;
    }

    return sum;
};