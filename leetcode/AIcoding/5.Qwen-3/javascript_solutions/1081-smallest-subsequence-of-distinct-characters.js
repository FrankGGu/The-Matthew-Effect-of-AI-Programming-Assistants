function smallestSubsequence(s, k) {
    const n = s.length;
    const stack = [];
    const seen = new Set();
    const count = new Array(26).fill(0);

    for (let i = 0; i < n; i++) {
        count[s[i].charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < n; i++) {
        const c = s[i];
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]--;

        if (seen.has(c)) continue;

        while (stack.length > 0 && stack[stack.length - 1] < c && count[stack[stack.length - 1].charCodeAt(0) - 'a'.charCodeAt(0)] > 0) {
            seen.delete(stack.pop());
        }

        stack.push(c);
        seen.add(c);
    }

    return stack.slice(0, k).join('');
}