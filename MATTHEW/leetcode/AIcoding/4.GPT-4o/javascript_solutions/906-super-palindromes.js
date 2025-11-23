var superpalindromesInRange = function(L, R) {
    let count = 0;
    const isPalindrome = (num) => {
        const str = num.toString();
        return str === str.split('').reverse().join('');
    };

    const isSuperPalindrome = (num) => {
        return isPalindrome(num) && isPalindrome(Math.sqrt(num));
    };

    const limit = Math.sqrt(R);
    for (let i = 1; i <= limit; i++) {
        const str = i.toString();
        const palindromes = [str, str.split('').reverse().join('')];
        for (const p of palindromes) {
            const num = BigInt(p + p.split('').reverse().join(''));
            if (num >= BigInt(L) && num <= BigInt(R) && isSuperPalindrome(num)) {
                count++;
            }
            const oddNum = BigInt(p + p.slice(1).split('').reverse().join(''));
            if (oddNum >= BigInt(L) && oddNum <= BigInt(R) && isSuperPalindrome(oddNum)) {
                count++;
            }
        }
    }
    return count;
};