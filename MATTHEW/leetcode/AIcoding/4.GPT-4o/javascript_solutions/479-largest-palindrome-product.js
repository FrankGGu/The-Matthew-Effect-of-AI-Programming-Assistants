var largestPalindrome = function(n) {
    if (n === 1) return 9;

    let upper = Math.pow(10, n) - 1;
    let lower = Math.pow(10, n - 1);

    let maxPalindrome = 0;

    for (let i = upper; i >= lower; i--) {
        for (let j = i; j >= lower; j--) {
            let product = i * j;
            if (product <= maxPalindrome) break;
            if (isPalindrome(product)) {
                maxPalindrome = Math.max(maxPalindrome, product);
            }
        }
    }

    return maxPalindrome % 1337;
};

function isPalindrome(num) {
    let str = num.toString();
    let reversedStr = str.split('').reverse().join('');
    return str === reversedStr;
}