var largestPalindromic = function(num) {
    let count = Array(10).fill(0);
    for (let c of num) {
        count[c - '0']++;
    }

    let half = '';
    let oddDigit = '';

    for (let i = 9; i >= 0; i--) {
        if (count[i] > 0) {
            if (count[i] % 2 === 1 && oddDigit === '') {
                oddDigit = i.toString();
            }
            half += i.toString().repeat(Math.floor(count[i] / 2));
        }
    }

    if (half === '' && oddDigit === '') return '0';
    if (half === '' && oddDigit !== '') return oddDigit;

    let palindromic = half + oddDigit + half.split('').reverse().join('');

    return palindromic[0] === '0' ? '0' : palindromic;
};