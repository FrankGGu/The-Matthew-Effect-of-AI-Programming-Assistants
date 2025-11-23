var smallestSubsequence = function(s) {
    const lastOccurrence = {};
    for (let i = 0; i < s.length; i++) {
        lastOccurrence[s[i]] = i;
    }

    const stack = [];
    const inStack = new Set();

    for (let i = 0; i < s.length; i++) {
        if (inStack.has(s[i])) continue;

        while (stack.length > 0 && s[i] < stack[stack.length - 1] && lastOccurrence[stack[stack.length - 1]] > i) {
            inStack.delete(stack.pop());
        }

        stack.push(s[i]);
        inStack.add(s[i]);
    }

    return stack.join('');
};