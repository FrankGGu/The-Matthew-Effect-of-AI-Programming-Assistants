const maximumScore = function(nums, k) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    const primes = sieve(Math.max(...nums));
    const primeScores = nums.map(num => calculatePrimeScore(num, primes));

    const left = new Array(n).fill(-1);
    const right = new Array(n).fill(n);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length && primeScores[stack[stack.length - 1]] < primeScores[i]) {
            stack.pop();
        }
        if (stack.length) {
            left[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    stack.length = 0;
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length && primeScores[stack[stack.length - 1]] <= primeScores[i]) {
            stack.pop();
        }
        if (stack.length) {
            right[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    const arr = nums.map((num, i) => ({
        num,
        count: (i - left[i]) * (right[i] - i)
    }));

    arr.sort((a, b) => b.num - a.num);

    let res = 1;
    let remaining = k;

    for (const { num, count } of arr) {
        if (remaining <= 0) break;
        const take = Math.min(count, remaining);
        res = (res * pow(num, take, MOD)) % MOD;
        remaining -= take;
    }

    return res;
};

function sieve(maxNum) {
    const isPrime = new Array(maxNum + 1).fill(true);
    isPrime[0] = isPrime[1] = false;
    for (let i = 2; i * i <= maxNum; i++) {
        if (isPrime[i]) {
            for (let j = i * i; j <= maxNum; j += i) {
                isPrime[j] = false;
            }
        }
    }
    const primes = [];
    for (let i = 2; i <= maxNum; i++) {
        if (isPrime[i]) primes.push(i);
    }
    return primes;
}

function calculatePrimeScore(num, primes) {
    if (num === 1) return 0;
    let score = 0;
    for (const prime of primes) {
        if (prime * prime > num) break;
        if (num % prime === 0) {
            score++;
            while (num % prime === 0) {
                num /= prime;
            }
        }
    }
    if (num > 1) score++;
    return score;
}

function pow(a, b, mod) {
    let res = 1;
    a %= mod;
    while (b > 0) {
        if (b % 2 === 1) res = (res * a) % mod;
        a = (a * a) % mod;
        b = Math.floor(b / 2);
    }
    return res;
}