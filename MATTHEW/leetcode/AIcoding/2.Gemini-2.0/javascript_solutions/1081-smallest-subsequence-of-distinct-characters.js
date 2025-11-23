var smallestSubsequence = function(s) {
    const lastIndex = {};
    for (let i = 0; i < s.length; i++) {
        lastIndex[s[i]] = i;
    }

    const stack = [];
    const seen = new Set();

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (seen.has(char)) {
            continue;
        }

        while (
            stack.length > 0 &&
            char < stack[stack.length - 1] &&
            lastIndex[stack[stack.length - 1]] > i
        ) {
            seen.delete(stack.pop());
        }

        stack.push(char);
        seen.add(char);
    }

    return stack.join('');
};