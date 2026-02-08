var recoverFromPreorder = function(S) {
    const stack = [];
    let i = 0;
    while (i < S.length) {
        let level = 0;
        while (i < S.length && S[i] === '-') {
            level++;
            i++;
        }
        let num = '';
        while (i < S.length && S[i] !== '-') {
            num += S[i];
            i++;
        }
        const node = new TreeNode(parseInt(num));
        if (stack.length === 0) {
            stack.push(node);
            continue;
        }
        while (stack.length > level) {
            stack.pop();
        }
        if (stack[stack.length - 1].left === null) {
            stack[stack.length - 1].left = node;
        } else {
            stack[stack.length - 1].right = node;
        }
        stack.push(node);
    }
    return stack[0];
};