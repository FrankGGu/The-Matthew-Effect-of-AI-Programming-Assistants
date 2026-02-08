var smallestSubsequence = function(s) {
    const stack = [];
    const seen = new Set();
    const lastOccurrence = {};

    for (let i = 0; i < s.length; i++) {
        lastOccurrence[s[i]] = i;
    }

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (seen.has(char)) continue;

        while (stack.length > 0 && char < stack[stack.length - 1] && i < lastOccurrence[stack[stack.length - 1]]) {
            seen.delete(stack.pop());
        }

        seen.add(char);
        stack.push(char);
    }

    return stack.join('');
};