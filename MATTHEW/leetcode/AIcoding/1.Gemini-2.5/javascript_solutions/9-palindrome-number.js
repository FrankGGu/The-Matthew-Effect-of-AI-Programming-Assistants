var isPalindrome = function(x) {
    if (x < 0) {
        return false;
    }

    const s = x.toString();
    const reversed_s = s.split('').reverse().join('');

    return s === reversed_s;
};