function makeSmallestPalindrome(s) {
    let n = s.length;
    let arr = s.split('');
    for (let i = 0; i < Math.floor(n / 2); i++) {
        arr[i] = arr[n - 1 - i] = Math.min(arr[i], arr[n - 1 - i]);
    }
    return arr.join('');
}