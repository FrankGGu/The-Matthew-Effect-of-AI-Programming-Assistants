var largestPalindrome = function(n, k) {
    if (n === 1) {
        return k === 9 ? "9" : String(9 % k);
    }

    const maxNum = Math.pow(10, n) - 1;
    const minNum = Math.pow(10, n - 1);

    for (let i = Math.floor(maxNum / k); i >= Math.ceil(minNum / k); i--) {
        const num = i * k;
        if (num > maxNum || num < minNum) continue;

        const numStr = String(num);
        let left = numStr.substring(0, Math.floor(n / 2));
        let right = left.split("").reverse().join("");

        let palindrome;
        if (n % 2 === 0) {
            palindrome = left + right;
        } else {
            palindrome = left + numStr[Math.floor(n / 2)] + right;
        }

        if (palindrome.length === n && parseInt(palindrome) % k === 0 && parseInt(palindrome) >= minNum && parseInt(palindrome) <= maxNum) {
            return palindrome;
        }
    }

    return "-1";
};