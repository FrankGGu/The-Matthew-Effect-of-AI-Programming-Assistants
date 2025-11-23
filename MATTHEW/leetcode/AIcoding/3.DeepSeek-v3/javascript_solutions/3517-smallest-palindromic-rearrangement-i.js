var smallestPalindrome = function(s) {
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }

    let oddChar = '';
    let half = '';
    for (const char in freq) {
        if (freq[char] % 2 !== 0) {
            if (oddChar !== '') {
                return '';
            }
            oddChar = char;
        }
        half += char.repeat(Math.floor(freq[char] / 2));
    }

    half = half.split('').sort().join('');
    return half + oddChar + half.split('').reverse().join('');
};