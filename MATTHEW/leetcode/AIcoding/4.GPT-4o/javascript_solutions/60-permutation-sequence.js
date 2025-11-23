var getPermutation = function(n, k) {
    const factorial = (num) => {
        let result = 1;
        for (let i = 1; i <= num; i++) {
            result *= i;
        }
        return result;
    };

    const nums = Array.from({ length: n }, (_, i) => i + 1);
    let kIndex = k - 1;
    let result = '';

    for (let i = n; i > 0; i--) {
        const fact = factorial(i - 1);
        const index = Math.floor(kIndex / fact);
        result += nums[index];
        nums.splice(index, 1);
        kIndex %= fact;
    }

    return result;
};