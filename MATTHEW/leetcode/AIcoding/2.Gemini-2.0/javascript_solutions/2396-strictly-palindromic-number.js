var isStrictlyPalindromic = function(n) {
    for (let base = 2; base <= n - 2; base++) {
        let num = n;
        let digits = [];
        while (num > 0) {
            digits.push(num % base);
            num = Math.floor(num / base);
        }

        let left = 0;
        let right = digits.length - 1;
        let isPalindrome = true;
        while (left < right) {
            if (digits[left] !== digits[right]) {
                isPalindrome = false;
                break;
            }
            left++;
            right--;
        }

        if (!isPalindrome) {
            return false;
        }
    }

    return true;
};