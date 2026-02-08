var removeDuplicateLetters = function(s) {
    const count = new Array(26).fill(0);
    const visited = new Array(26).fill(false);
    const stack = [];

    for (let i = 0; i < s.length; i++) {
        count[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        const charCode = char.charCodeAt(0) - 'a'.charCodeAt(0);

        count[charCode]--;

        if (visited[charCode]) {
            continue;
        }

        while (stack.length > 0 && char < stack[stack.length - 1] && count[stack[stack.length - 1].charCodeAt(0) - 'a'.charCodeAt(0)] > 0) {
            const poppedChar = stack.pop();
            visited[poppedChar.charCodeAt(0) - 'a'.charCodeAt(0)] = false;
        }

        stack.push(char);
        visited[charCode] = true;
    }

    return stack.join('');
};