var removePalindromeSub = function(s) {
    if (s.length === 0) return 0;
    let isPalindrome = true;
    for (let i = 0; i < s.length / 2; i++) {
        if (s[i] !== s[s.length - 1 - i]) {
            isPalindrome = false;
            break;
        }
    }
    return isPalindrome ? 1 : 2;
};