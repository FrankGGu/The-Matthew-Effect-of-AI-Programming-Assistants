var primeSubOperation = function(nums) {
    function isPrime(n) {
        if (n <= 1) return false;
        for (let i = 2; i * i <= n; i++) {
            if (n % i === 0) return false;
        }
        return true;
    }

    function getLargestPrimeLessThan(n) {
        for (let p = n - 1; p >= 2; p--) {
            if (isPrime(p)) {
                return p;
            }
        }
        return 0;
    }

    let prev = 0;
    for (let i = 0; i < nums.length; i++) {
        let current = nums[i];
        if (current <= prev) {
            return false;
        }
        let p = getLargestPrimeLessThan(current - prev);
        if (p > 0) {
            current -= p;
        }
        prev = current;
    }
    return true;
};