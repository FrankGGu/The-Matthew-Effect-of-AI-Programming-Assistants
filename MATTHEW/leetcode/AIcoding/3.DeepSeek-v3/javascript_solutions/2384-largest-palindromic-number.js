var largestPalindromic = function(num) {
    const count = new Array(10).fill(0);
    for (const c of num.toString()) {
        count[parseInt(c)]++;
    }

    let firstHalf = '';
    let mid = '';

    for (let i = 9; i >= 0; i--) {
        if (i === 0 && firstHalf.length === 0) continue;
        while (count[i] > 1) {
            firstHalf += i.toString();
            count[i] -= 2;
        }
        if (count[i] === 1 && mid === '') {
            mid = i.toString();
        }
    }

    const result = firstHalf + mid + firstHalf.split('').reverse().join('');
    return result === '' ? '0' : result;
};