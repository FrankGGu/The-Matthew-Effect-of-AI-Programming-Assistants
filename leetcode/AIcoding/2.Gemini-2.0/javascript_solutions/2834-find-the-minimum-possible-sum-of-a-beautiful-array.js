var minSum = function(n, target) {
    let sum = 0;
    let count = 0;
    let set = new Set();
    for (let i = 1; count < n; i++) {
        if (!set.has(i)) {
            sum += i;
            set.add(target - i);
            count++;
        }
    }
    return sum;
};