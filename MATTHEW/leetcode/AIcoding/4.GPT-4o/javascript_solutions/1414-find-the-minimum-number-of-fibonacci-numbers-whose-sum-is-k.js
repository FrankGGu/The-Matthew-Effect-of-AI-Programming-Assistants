var findMinFibonacciNumbers = function(k) {
    const fib = [1, 1];
    while (fib[fib.length - 1] < k) {
        fib.push(fib[fib.length - 1] + fib[fib.length - 2]);
    }
    let count = 0;
    for (let i = fib.length - 1; i >= 0; i--) {
        if (k === 0) break;
        if (fib[i] <= k) {
            k -= fib[i];
            count++;
        }
    }
    return count;
};