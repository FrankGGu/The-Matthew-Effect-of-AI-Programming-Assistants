function removeDuplicateLetters(s) {
    const lastIndices = {};
    const visited = new Set();
    const stack = [];

    for (let i = 0; i < s.length; i++) {
        lastIndices[s[i]] = i;
    }

    for (let i = 0; i < s.length; i++) {
        if (visited.has(s[i])) continue;

        while (stack.length > 0 && s[i] < stack[stack.length - 1] && lastIndices[stack[stack.length - 1]] > i) {
            visited.delete(stack.pop());
        }

        stack.push(s[i]);
        visited.add(s[i]);
    }

    return stack.join('');
}