var removeDuplicateLetters = function(s) {
    const lastIndex = {};
    for (let i = 0; i < s.length; i++) {
        lastIndex[s[i]] = i;
    }

    const stack = [];
    const seen = new Set();

    for (let i = 0; i < s.length; i++) {
        if (seen.has(s[i])) continue;

        while (stack.length > 0 && s[i] < stack[stack.length - 1] && lastIndex[stack[stack.length - 1]] > i) {
            seen.delete(stack.pop());
        }

        stack.push(s[i]);
        seen.add(s[i]);
    }

    return stack.join('');
};