var robotWithString = function(s) {
    const stack = [];
    const freq = Array(26).fill(0);
    const a = 'a'.charCodeAt(0);
    for (const c of s) {
        freq[c.charCodeAt(0) - a]++;
    }
    let res = [];
    for (const c of s) {
        stack.push(c);
        freq[c.charCodeAt(0) - a]--;
        while (stack.length > 0) {
            const top = stack[stack.length - 1];
            let hasSmaller = false;
            for (let i = 0; i < top.charCodeAt(0) - a; i++) {
                if (freq[i] > 0) {
                    hasSmaller = true;
                    break;
                }
            }
            if (!hasSmaller) {
                res.push(stack.pop());
            } else {
                break;
            }
        }
    }
    while (stack.length > 0) {
        res.push(stack.pop());
    }
    return res.join('');
};