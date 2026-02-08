function robotWithString(s) {
    const stack = [];
    const result = [];
    const freq = Array(26).fill(0);

    for (const char of s) {
        freq[char.charCodeAt(0) - 97]++;
    }

    for (const char of s) {
        stack.push(char);
        freq[char.charCodeAt(0) - 97]--;

        while (stack.length > 0 && (stack[stack.length - 1] <= String.fromCharCode(97 + freq.findIndex(v => v > 0)))) {
            result.push(stack.pop());
        }
    }

    return result.join('');
}