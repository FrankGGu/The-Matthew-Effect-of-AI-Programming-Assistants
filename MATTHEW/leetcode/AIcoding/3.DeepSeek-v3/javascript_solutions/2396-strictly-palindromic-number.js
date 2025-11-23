var isStrictlyPalindromic = function(n) {
    for (let base = 2; base <= n - 2; base++) {
        let num = n;
        let converted = '';
        while (num > 0) {
            converted = (num % base) + converted;
            num = Math.floor(num / base);
        }
        if (!isPalindrome(converted)) {
            return false;
        }
    }
    return true;
};

function isPalindrome(s) {
    let left = 0;
    let right = s.length - 1;
    while (left < right) {
        if (s[left] !== s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}