var deserialize = function(s) {
    if (s.length === 0) {
        return new NestedInteger();
    }

    if (s[0] !== '[') {
        return new NestedInteger().setInteger(parseInt(s));
    }

    let stack = [];
    let current = null;
    let i = 0;

    while (i < s.length) {
        const char = s[i];

        if (char === '[') {
            const newList = new NestedInteger();
            if (current !== null) {
                stack.push(current);
            }
            current = newList;
            i++;
        } else if (char === ']') {
            if (stack.length > 0) {
                const prevList = stack.pop();
                prevList.add(current);
                current = prevList;
            }
            i++;
        } else if (char === ',') {
            i++;
        } else {
            let start = i;
            while (i < s.length && (s[i] === '-' || (s[i] >= '0' && s[i] <= '9'))) {
                i++;
            }
            const numStr = s.substring(start, i);
            const num = parseInt(numStr);
            const intNi = new NestedInteger().setInteger(num);

            if (current !== null) {
                current.add(intNi);
            }
        }
    }

    return current;
};