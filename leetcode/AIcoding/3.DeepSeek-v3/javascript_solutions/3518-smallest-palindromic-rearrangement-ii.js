var smallestPalindrome = function(s) {
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }

    let oddChar = '';
    let countOdd = 0;
    for (const char in freq) {
        if (freq[char] % 2 !== 0) {
            countOdd++;
            oddChar = char;
            if (countOdd > 1) {
                return '';
            }
        }
    }

    let half = '';
    const sortedChars = Object.keys(freq).sort();
    for (const char of sortedChars) {
        half += char.repeat(Math.floor(freq[char] / 2));
    }

    const palindrome = half + oddChar + half.split('').reverse().join('');
    return palindrome;
};