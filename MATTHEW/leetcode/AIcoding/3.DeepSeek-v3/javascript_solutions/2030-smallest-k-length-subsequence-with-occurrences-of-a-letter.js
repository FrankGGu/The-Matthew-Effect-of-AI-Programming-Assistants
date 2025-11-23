var smallestSubsequence = function(s, k, letter, repetition) {
    const stack = [];
    let count = 0;
    for (const c of s) {
        if (c === letter) count++;
    }
    let toDelete = s.length - k;
    let inStack = 0;

    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        while (stack.length > 0 && c < stack[stack.length - 1] && toDelete > 0) {
            if (stack[stack.length - 1] === letter) {
                if (count <= repetition - inStack) break;
                inStack--;
            }
            stack.pop();
            toDelete--;
        }
        stack.push(c);
        if (c === letter) {
            inStack++;
            count--;
        }
    }

    let res = [];
    let added = 0;
    for (let i = 0; i < stack.length; i++) {
        if (added >= k) break;
        const c = stack[i];
        if (c === letter) {
            res.push(c);
            added++;
        } else if (k - res.length > repetition - added) {
            res.push(c);
            added++;
        }
    }

    return res.join('');
};