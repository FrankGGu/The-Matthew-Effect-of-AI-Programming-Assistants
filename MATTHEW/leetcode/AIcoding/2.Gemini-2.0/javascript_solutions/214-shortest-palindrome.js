var shortestPalindrome = function(s) {
    let n = s.length;
    let rev_s = s.split("").reverse().join("");
    for (let i = n; i >= 0; i--) {
        if (s.substring(0, i) === rev_s.substring(n - i)) {
            return rev_s.substring(0, n - i) + s;
        }
    }
    return "";
};