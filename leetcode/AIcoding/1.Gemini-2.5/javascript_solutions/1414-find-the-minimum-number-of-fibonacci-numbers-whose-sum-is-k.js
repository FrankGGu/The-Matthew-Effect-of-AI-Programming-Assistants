function findMinFibonacciNumbers(k) {
    let fib = [1, 1];
    while (fib[fib.length - 1] < k) {
        fib.push(fib[fib.length - 1] + fib[fib.length - 2]);
    }

    let count = 0;
    for (let i = fib.length - 1; i >= 0 && k > 0; i--) {
        if (fib[i] <= k) {
            k -= fib[i];
            count++;
        }
    }
    return count;
}