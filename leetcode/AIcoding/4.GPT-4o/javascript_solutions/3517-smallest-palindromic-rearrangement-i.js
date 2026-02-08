function smallestPalindromic(s) {
    const count = Array(10).fill(0);
    for (const char of s) {
        count[char.charCodeAt(0) - '0'.charCodeAt(0)]++;
    }

    let half = '';
    let oddChar = '';
    for (let i = 0; i < 10; i++) {
        if (count[i] % 2 === 1) {
            if (oddChar === '' || oddChar > String.fromCharCode(i + '0'.charCodeAt(0))) {
                oddChar = String.fromCharCode(i + '0'.charCodeAt(0));
            }
        }
        half += String.fromCharCode(i + '0'.charCodeAt(0)).repeat(Math.floor(count[i] / 2));
    }

    if (half === '' && oddChar === '') return '0';

    half = half.split('').sort().join('');
    const palindrome = half + (oddChar ? oddChar : '') + [...half].reverse().join('');

    return palindrome;
}