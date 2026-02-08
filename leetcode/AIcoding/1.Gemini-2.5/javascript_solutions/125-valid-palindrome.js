var isPalindrome = function(s) {
    let left = 0;
    let right = s.length - 1;

    const isAlphaNumeric = (char) => {
        const code = char.charCodeAt(0);
        return (code >= 48 && code <= 57) || // numeric (0-9)
               (code >= 65 && code <= 90) || // upper alpha (A-Z)
               (code >= 97 && code <= 122);  // lower alpha (a-z)
    };

    while (left < right) {
        while (left < right && !isAlphaNumeric(s[left])) {
            left++;
        }
        while (left < right && !isAlphaNumeric(s[right])) {
            right--;
        }

        if (left < right) {
            if (s[left].toLowerCase() !== s[right].toLowerCase()) {
                return false;
            }
            left++;
            right--;
        }
    }

    return true;
};