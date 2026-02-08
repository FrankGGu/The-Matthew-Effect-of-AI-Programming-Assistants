var recoverFromPreorder = function(S) {
    const stack = [];
    let i = 0;

    while (i < S.length) {
        let level = 0;
        while (i < S.length && S[i] === '-') {
            level++;
            i++;
        }

        let value = 0;
        while (i < S.length && S[i] >= '0' && S[i] <= '9') {
            value = value * 10 + (S[i] - '0');
            i++;
        }

        const node = new TreeNode(value);
        if (level === stack.length) {
            if (stack.length > 0) {
                stack[stack.length - 1].children.push(node);
            }
        } else {
            while (level < stack.length) {
                stack.pop();
            }
            if (stack.length > 0) {
                stack[stack.length - 1].children.push(node);
            }
        }
        stack.push(node);
    }

    return stack[0];
};