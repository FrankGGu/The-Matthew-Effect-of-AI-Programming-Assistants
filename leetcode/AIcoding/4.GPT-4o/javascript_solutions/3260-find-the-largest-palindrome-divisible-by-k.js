var largestPalindrome = function(n, k) {
    const mod = 10 ** 9 + 7;

    const isPalindrome = (num) => {
        const str = num.toString();
        return str === str.split('').reverse().join('');
    };

    let maxPalin = 0;

    for (let i = Math.pow(10, n) - 1; i >= Math.pow(10, n - 1); i--) {
        for (let j = i; j >= Math.pow(10, n - 1); j--) {
            const product = i * j;
            if (product <= maxPalin) break;

            if (isPalindrome(product) && product % k === 0) {
                maxPalin = Math.max(maxPalin, product);
            }
        }
    }

    return maxPalin % mod;
};