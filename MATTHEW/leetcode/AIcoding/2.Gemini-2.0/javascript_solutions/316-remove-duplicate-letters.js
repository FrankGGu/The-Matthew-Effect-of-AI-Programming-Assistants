var removeDuplicateLetters = function(s) {
    const count = {};
    const seen = {};
    const stack = [];

    for (const char of s) {
        count[char] = (count[char] || 0) + 1;
    }

    for (const char of s) {
        count[char]--;

        if (seen[char]) {
            continue;
        }

        while (stack.length > 0 && char < stack[stack.length - 1] && count[stack[stack.length - 1]] > 0) {
            seen[stack.pop()] = false;
        }

        stack.push(char);
        seen[char] = true;
    }

    return stack.join('');
};