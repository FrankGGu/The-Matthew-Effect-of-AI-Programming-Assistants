var findMinFibonacciNumbers = function(k) {
    let fib = [1, 1];
    while (fib[fib.length - 1] < k) {
        fib.push(fib[fib.length - 1] + fib[fib.length - 2]);
    }

    let count = 0;
    let remaining = k;
    for (let i = fib.length - 1; i >= 0 && remaining > 0; i--) {
        if (fib[i] <= remaining) {
            remaining -= fib[i];
            count++;
        }
    }
    return count;
};