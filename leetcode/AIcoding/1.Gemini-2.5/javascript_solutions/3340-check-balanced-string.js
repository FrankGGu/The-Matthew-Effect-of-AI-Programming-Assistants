var isValid = function(s) {
    const stack = [];
    const map = {
        "(": ")",
        "[": "]",
        "{": "}"
    };

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (map[char]) { // It's an opening bracket
            stack.push(char);
        } else { // It's a closing bracket
            if (stack.length === 0) {
                return false;
            }
            const lastOpen = stack.pop();
            if (map[lastOpen] !== char) {
                return false;
            }
        }
    }

    return stack.length === 0;
};