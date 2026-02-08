var findMinFibonacciNumbers = function(k) {
    let fib = [1, 1];
    while (fib[fib.length - 1] <= k) {
        fib.push(fib[fib.length - 1] + fib[fib.length - 2]);
    }

    let count = 0;
    for (let i = fib.length - 2; i >= 0; i--) {
        if (k >= fib[i]) {
            k -= fib[i];
            count++;
        }
    }

    return count;
};