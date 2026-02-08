var primeSubtractionOperation = function(nums) {
    const SIEVE_LIMIT = 32000; // Approx sqrt(10^9)
    const is_prime_sieve = new Array(SIEVE_LIMIT + 1).fill(true);
    is_prime_sieve[0] = is_prime_sieve[1] = false;
    const primes = [];
    for (let p = 2; p <= SIEVE_LIMIT; p++) {
        if (is_prime_sieve[p]) {
            primes.push(p);
            for (let multiple = p * p; multiple <= SIEVE_LIMIT; multiple += p) {
                is_prime_sieve[multiple] = false;
            }
        }
    }

    function isPrime(num) {
        if (num <= 1) return false;
        if (num <= SIEVE_LIMIT) return is_prime_sieve[num];

        for (const p of primes) {
            if (p * p > num) break;
            if (num % p === 0) return false;
        }
        return true;
    }

    function findLargestPrimeLe(K) {
        if (K < 2) return -1;

        if (K <= SIEVE_LIMIT) {
            let low = 0, high = primes.length - 1;
            let ans = -1;
            while (low <= high) {
                let mid = Math.floor((low + high) / 2);
                if (primes[mid] <= K) {
                    ans = primes[mid];
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
            return ans;
        }

        for (let num = K; num >= 2; num--) {
            if (isPrime(num)) {
                return num;
            }
        }
        return -1; 
    }

    let current_min_val = 0;

    for (let i = 0; i < nums.length; i++) {
        const val = nums[i];

        if (val <= current_min_val) {
            const max_p_candidate = val - current_min_val - 1;
            const p_star = findLargestPrimeLe(max_p_candidate);

            if (p_star === -1 || val - p_star < 0) {
                return false;
            }
            current_min_val = val - p_star;

        } else {
            const max_p_candidate = val - current_min_val - 1;
            const p_star = findLargestPrimeLe(max_p_candidate);

            if (p_star !== -1 && val - p_star >= 0) {
                current_min_val = Math.min(val, val - p_star);
            } else {
                current_min_val = val;
            }
        }
    }

    return true;
};