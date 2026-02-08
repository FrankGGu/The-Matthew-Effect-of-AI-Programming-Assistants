var braceExpansionII = function(expression) {
    const stack = [];
    stack.push([]);
    for (let i = 0; i < expression.length; i++) {
        const c = expression[i];
        if (c === '{') {
            stack.push([]);
            stack.push([]);
        } else if (c === '}') {
            const temp = [];
            const top = stack.pop();
            const prev = stack.pop();
            for (const s1 of prev) {
                for (const s2 of top) {
                    temp.push(s1 + s2);
                }
            }
            stack[stack.length - 1].push(...temp);
        } else if (c === ',') {
            stack.push([]);
        } else {
            const temp = [];
            const top = stack.pop();
            if (top.length === 0) {
                temp.push(c);
            } else {
                for (const s of top) {
                    temp.push(s + c);
                }
            }
            stack.push(temp);
        }
    }
    const result = stack.pop();
    return [...new Set(result)].sort();
};