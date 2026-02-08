var isValid = function(s) {
    const stack = [];
    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (char === 'a' || char === 'b') {
            stack.push(char);
        } else if (char === 'c') {
            if (stack.length < 2) {
                return false;
            }
            const top = stack.pop();
            const secondTop = stack.pop();

            if (top !== 'b' || secondTop !== 'a') {
                return false;
            }
        } else {
            // According to problem constraints, s consists of lowercase English letters.
            // If any character other than 'a', 'b', 'c' is encountered, it's invalid.
            return false; 
        }
    }

    return stack.length === 0;
};