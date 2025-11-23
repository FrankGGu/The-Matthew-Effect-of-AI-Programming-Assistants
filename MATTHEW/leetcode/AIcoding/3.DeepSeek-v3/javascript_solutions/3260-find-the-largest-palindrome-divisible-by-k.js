var largestPalindrome = function(n, k) {
    let max = Math.pow(10, n) - 1;
    let min = Math.pow(10, n - 1);
    let largest = -1;

    for (let i = max; i >= min; i--) {
        let numStr = i.toString();
        let palindromeStr = numStr + numStr.split('').reverse().join('');
        let palindrome = parseInt(palindromeStr, 10);

        if (palindrome % k === 0) {
            largest = Math.max(largest, palindrome);
        }
    }

    for (let i = max; i >= min; i--) {
        let numStr = i.toString();
        let reversed = numStr.split('').reverse().join('');
        for (let j = 9; j >= 0; j--) {
            let palindromeStr = numStr + j + reversed;
            let palindrome = parseInt(palindromeStr, 10);

            if (palindrome % k === 0) {
                largest = Math.max(largest, palindrome);
            }
        }
    }

    return largest === -1 ? 0 : largest % 1337;
};