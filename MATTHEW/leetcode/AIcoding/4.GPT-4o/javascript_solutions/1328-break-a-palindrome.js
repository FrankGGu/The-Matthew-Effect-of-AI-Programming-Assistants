function breakPalindrome(palindrome) {
    if (palindrome.length <= 1) return "";

    for (let i = 0; i < palindrome.length; i++) {
        if (palindrome[i] !== 'a') {
            return palindrome.slice(0, i) + 'a' + palindrome.slice(i + 1);
        }
    }

    return palindrome.slice(0, palindrome.length - 1) + 'b';
}