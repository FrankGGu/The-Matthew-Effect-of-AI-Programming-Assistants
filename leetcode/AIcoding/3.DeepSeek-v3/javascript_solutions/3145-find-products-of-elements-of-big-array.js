function productOfBigArrayElements(primeFactors, queries) {
    const MOD = 1e9 + 7;
    const maxPrime = Math.max(...primeFactors);
    const spf = Array(maxPrime + 1).fill(0);
    for (let i = 2; i <= maxPrime; i++) {
        if (spf[i] === 0) {
            spf[i] = i;
            for (let j = i * i; j <= maxPrime; j += i) {
                if (spf[j] === 0) spf[j] = i;
            }
        }
    }

    const primeCount = {};
    for (const num of primeFactors) {
        let x = num;
        while (x > 1) {
            const p = spf[x];
            while (x % p === 0) {
                primeCount[p] = (primeCount[p] || 0) + 1;
                x = Math.floor(x / p);
            }
        }
    }

    const primes = Object.keys(primeCount).map(Number).sort((a, b) => a - b);
    const prefixSum = [0];
    for (const p of primes) {
        prefixSum.push(prefixSum[prefixSum.length - 1] + primeCount[p]);
    }

    function getProduct(l, r) {
        let product = 1n;
        let left = 0, right = primes.length - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (prefixSum[mid] < l) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        const startPrimeIdx = right + 1;

        left = 0, right = primes.length - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (prefixSum[mid + 1] <= r) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        const endPrimeIdx = left - 1;

        if (startPrimeIdx > endPrimeIdx) {
            return 1;
        }

        for (let i = startPrimeIdx; i <= endPrimeIdx; i++) {
            const p = primes[i];
            const cntStart = Math.max(l, prefixSum[i] + 1) - prefixSum[i] - 1;
            const cntEnd = Math.min(r, prefixSum[i + 1]) - prefixSum[i];
            const total = cntEnd - cntStart;
            if (total > 0) {
                let pow = BigInt(p);
                let exp = total;
                let res = 1n;
                while (exp > 0) {
                    if (exp % 2 === 1) {
                        res = (res * pow) % BigInt(MOD);
                    }
                    pow = (pow * pow) % BigInt(MOD);
                    exp = Math.floor(exp / 2);
                }
                product = (product * res) % BigInt(MOD);
            }
        }

        return Number(product);
    }

    const result = [];
    for (const [l, r, mod] of queries) {
        const product = getProduct(l, r);
        result.push(product % mod);
    }
    return result;
}