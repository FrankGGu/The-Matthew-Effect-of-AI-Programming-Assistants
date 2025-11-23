var deserialize = function(s) {
    if (s[0] !== '[') {
        return new NestedInteger(parseInt(s));
    }

    let stack = [];
    let num = '';
    let sign = 1;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '[') {
            stack.push(new NestedInteger());
        } else if (s[i] === '-') {
            sign = -1;
        } else if (s[i] >= '0' && s[i] <= '9') {
            num += s[i];
        } else if (s[i] === ',' || s[i] === ']') {
            if (num !== '') {
                stack[stack.length - 1].add(new NestedInteger(sign * parseInt(num)));
                num = '';
                sign = 1;
            }

            if (s[i] === ']' && stack.length > 1) {
                let nested = stack.pop();
                stack[stack.length - 1].add(nested);
            }
        }
    }

    return stack.pop();
};