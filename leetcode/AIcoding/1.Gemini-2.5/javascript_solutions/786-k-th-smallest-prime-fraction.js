var kthSmallestPrimeFraction = function(prime, k) {
    const n = prime.length;

    const check = (mid) => {
        let count = 0;
        let maxNum = 0; 
        let maxDen = 1; 
        let i = 0; 

        for (let j = 1; j < n; j++) {
            while (i < j && prime[i] <= mid * prime[j]) {
                i++;
            }

            count += i;

            if (i > 0) {
                // Compare prime[i-1] / prime[j] with maxNum / maxDen
                // Using cross-multiplication to avoid floating point division issues for comparison
                if (prime[i-1] * maxDen > maxNum * prime[j]) {
                    maxNum = prime[i-1];
                    maxDen = prime[j];
                }
            }
        }
        return [count, maxNum, maxDen];
    };

    let low = 0.0;
    let high = 1.0;
    let ansNum = 0;
    let ansDen = 1;

    for (let iter = 0; iter < 100; iter++) { // A fixed number of iterations for sufficient precision
        let mid = (low + high) / 2.0;
        const [count, num, den] = check(mid);

        if (count < k) {
            low = mid;
        } else {
            ansNum = num;
            ansDen = den;
            high = mid;
        }
    }

    return [ansNum, ansDen];
};