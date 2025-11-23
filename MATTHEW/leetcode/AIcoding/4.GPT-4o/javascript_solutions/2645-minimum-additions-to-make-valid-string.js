var minAddToMakeValid = function(s) {
    let left = 0, right = 0;
    for (let char of s) {
        if (char === '(') {
            left++;
        } else if (char === ')') {
            if (left > 0) {
                left--;
            } else {
                right++;
            }
        }
    }
    return left + right;
};