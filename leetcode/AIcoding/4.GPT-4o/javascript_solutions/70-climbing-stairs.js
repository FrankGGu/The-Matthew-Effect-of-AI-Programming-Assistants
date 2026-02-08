var climbStairs = function(n) {
    if (n <= 2) return n;
    let first = 1, second = 2;
    for (let i = 3; i <= n; i++) {
        let temp = second;
        second += first;
        first = temp;
    }
    return second;
};