var countNumbersWithUniqueDigits = function(n) {
    if (n === 0) {
        return 1;
    }

    let ans = 10;
    let currentProduct = 9;
    let availableDigits = 9;

    for (let i = 2; i <= n; i++) {
        currentProduct = currentProduct * availableDigits;
        ans += currentProduct;
        availableDigits--;
        if (availableDigits === 0) {
            break; 
        }
    }

    return ans;
};