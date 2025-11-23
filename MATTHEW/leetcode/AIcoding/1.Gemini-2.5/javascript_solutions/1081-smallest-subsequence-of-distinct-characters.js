var smallestSubsequence = function(s) {
    const counts = new Map();
    for (const char of s) {
        counts.set(char, (counts.get(char) || 0) + 1);
    }

    const stack = [];
    const visited = new Set();

    for (const char of s) {
        counts.set(char, counts.get(char) - 1);

        if (visited.has(char)) {
            continue;
        }

        while (stack.length > 0 && char < stack[stack.length - 1] && counts.get(stack[stack.length - 1]) > 0) {
            const poppedChar = stack.pop();
            visited.delete(poppedChar);
        }

        stack.push(char);
        visited.add(char);
    }

    return stack.join('');
};