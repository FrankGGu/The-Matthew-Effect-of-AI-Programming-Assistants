function kMirror(k, n) {
    function isPalindrome(s) {
        return s === s.split('').reverse().join('');
    }

    function generatePalindromes(length) {
        const palindromes = [];
        const start = Math.pow(10, Math.floor((length - 1) / 2));
        const end = Math.pow(10, Math.ceil((length - 1) / 2));
        for (let i = start; i < end; i++) {
            const s = i.toString();
            let palindrome = s;
            if (length % 2 === 0) {
                palindrome += s.split('').reverse().join('');
            } else {
                palindrome += s.slice(0, -1).split('').reverse().join('');
            }
            palindromes.push(parseInt(palindrome, 10));
        }
        return palindromes;
    }

    let length = 1;
    while (true) {
        const palindromes = generatePalindromes(length);
        for (const p of palindromes) {
            if (p.toString(k) === p.toString(k).split('').reverse().join('')) {
                n--;
                if (n === 0) {
                    return p;
                }
            }
        }
        length++;
    }
}