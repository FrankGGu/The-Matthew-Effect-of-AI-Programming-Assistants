var fib = function(N) {
    if (N === 0) return 0;
    if (N === 1) return 1;
    let a = 0, b = 1;
    for (let i = 2; i <= N; i++) {
        let temp = b;
        b = a + b;
        a = temp;
    }
    return b;
};