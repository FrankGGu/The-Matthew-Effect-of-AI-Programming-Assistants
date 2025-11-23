var superpalindromesInRange = function(left, right) {
    let count = 0;
    let leftSqrt = Math.ceil(Math.sqrt(left));
    let rightSqrt = Math.floor(Math.sqrt(right));

    function isPalindrome(num) {
        let numStr = num.toString();
        let left = 0;
        let right = numStr.length - 1;
        while (left < right) {
            if (numStr[left] !== numStr[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    for (let i = 1; i <= 100000; i++) {
        let s = i.toString();
        let palindrome1 = s + s.split("").reverse().join("");
        let num1 = parseInt(palindrome1);
        if (num1 >= leftSqrt && num1 <= rightSqrt && isPalindrome(num1 * num1)) {
            count++;
        }

        let palindrome2 = s + s.slice(0, s.length - 1).split("").reverse().join("");
        let num2 = parseInt(palindrome2);
        if (num2 >= leftSqrt && num2 <= rightSqrt && isPalindrome(num2 * num2)) {
            count++;
        }
    }

    return count;
};