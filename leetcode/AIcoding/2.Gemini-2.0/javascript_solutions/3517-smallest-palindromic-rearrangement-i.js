var makeSmallestPalindrome = function(s) {
    const n = s.length;
    const arr = s.split('');
    for (let i = 0; i < Math.floor(n / 2); i++) {
        if (arr[i] !== arr[n - 1 - i]) {
            arr[i] = arr[n - 1 - i] = String.fromCharCode(Math.min(arr[i].charCodeAt(0), arr[n - 1 - i].charCodeAt(0)));
        }
    }
    return arr.join('');
};