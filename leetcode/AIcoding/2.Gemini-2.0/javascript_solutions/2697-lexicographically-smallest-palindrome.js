var makeSmallestPalindrome = function(s) {
    let n = s.length;
    let arr = s.split('');
    for (let i = 0; i < Math.floor(n / 2); i++) {
        if (arr[i] !== arr[n - 1 - i]) {
            arr[i] = arr[i] < arr[n - 1 - i] ? arr[i] : arr[n - 1 - i];
            arr[n - 1 - i] = arr[i];
        }
    }
    return arr.join('');
};