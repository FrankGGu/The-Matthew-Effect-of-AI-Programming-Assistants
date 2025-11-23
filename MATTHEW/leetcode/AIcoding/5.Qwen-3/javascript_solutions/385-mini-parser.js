function deserialize(s) {
    if (s[0] !== '[') {
        return new NestedInteger().setInteger(parseInt(s));
    }
    let stack = [];
    let current = null;
    let num = '';
    for (let i = 1; i < s.length - 1; i++) {
        if (s[i] === '[') {
            stack.push(current);
            current = new NestedInteger();
        } else if (s[i] === ']') {
            if (num !== '') {
                current.add(new NestedInteger().setInteger(parseInt(num)));
                num = '';
            }
            if (stack.length > 0) {
                current = stack.pop();
            }
        } else if (s[i] === ',') {
            if (num !== '') {
                current.add(new NestedInteger().setInteger(parseInt(num)));
                num = '';
            }
        } else {
            num += s[i];
        }
    }
    if (num !== '') {
        current.add(new NestedInteger().setInteger(parseInt(num)));
    }
    return current;
}