var kthPalindrome = function(queries, intLength) {
    let result = [];
    let halfLength = Math.floor((intLength + 1) / 2);
    let start = Math.pow(10, halfLength - 1);
    let end = Math.pow(10, halfLength) - 1;

    for (let q of queries) {
        let num = start + q - 1;
        if (num > end) {
            result.push(-1);
        } else {
            let half = num.toString();
            let palindrome = half;
            if (intLength % 2 === 0) {
                palindrome += half.split('').reverse().join('');
            } else {
                palindrome += half.slice(0, half.length - 1).split('').reverse().join('');
            }
            result.push(parseInt(palindrome));
        }
    }

    return result;
};