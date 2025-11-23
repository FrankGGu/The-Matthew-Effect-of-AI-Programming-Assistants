var removeDuplicateLetters = function(s) {
    const lastIndex = new Array(26).fill(0);
    for (let i = 0; i < s.length; i++) {
        lastIndex[s.charCodeAt(i) - 'a'.charCodeAt(0)] = i;
    }

    const stack = [];
    const seen = new Set();

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (seen.has(char)) continue;

        while (stack.length && char < stack[stack.length - 1] && lastIndex[stack[stack.length - 1].charCodeAt(0) - 'a'.charCodeAt(0)] > i) {
            seen.delete(stack.pop());
        }

        stack.push(char);
        seen.add(char);
    }

    return stack.join('');
};