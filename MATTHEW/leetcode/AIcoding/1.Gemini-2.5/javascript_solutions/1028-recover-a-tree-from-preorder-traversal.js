var recoverFromPreorder = function(S) {
    const stack = []; // Stores [node, depth]
    let root = null;
    let i = 0;

    while (i < S.length) {
        let currentDepth = 0;
        while (i < S.length && S[i] === '-') {
            currentDepth++;
            i++;
        }

        let val = 0;
        while (i < S.length && S[i] >= '0' && S[i] <= '9') {
            val = val * 10 + (S[i] - '0');
            i++;
        }

        const newNode = new TreeNode(val);

        while (stack.length > 0 && stack[stack.length - 1][1] >= currentDepth) {
            stack.pop();
        }

        if (stack.length > 0) {
            const parent = stack[stack.length - 1][0];
            if (parent.left === null) {
                parent.left = newNode;
            } else {
                parent.right = newNode;
            }
        } else {
            root = newNode;
        }

        stack.push([newNode, currentDepth]);
    }

    return root;
};