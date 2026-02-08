var parseBoolExpr = function(expression) {
    let stack = [];
    for (let c of expression) {
        if (c === ',') continue;
        if (c !== ')') {
            stack.push(c);
        } else {
            let t = 0, f = 0;
            while (stack[stack.length - 1] !== '(') {
                let val = stack.pop();
                if (val === 't') t++;
                else f++;
            }
            stack.pop(); // pop '('
            let op = stack.pop();
            let res;
            if (op === '!') {
                res = f === 1 ? 't' : 'f';
            } else if (op === '&') {
                res = f === 0 ? 't' : 'f';
            } else if (op === '|') {
                res = t > 0 ? 't' : 'f';
            }
            stack.push(res);
        }
    }
    return stack.pop() === 't';
};