function recoverFromPreorder(S) {
    let stack = [];
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
        let node = new TreeNode(value);

        if (level === stack.length) {
            if (stack.length > 0) {
                stack[stack.length - 1].left = node;
            }
        } else {
            while (level < stack.length) {
                stack.pop();
            }
            stack[stack.length - 1].right = node;
        }
        stack.push(node);
    }

    return stack[0];
}