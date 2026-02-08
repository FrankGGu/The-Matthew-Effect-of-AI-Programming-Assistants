var postorder = function(root) {
    const result = [];
    if (!root) return result;

    const stack = [root];

    while (stack.length > 0) {
        const node = stack.pop();
        result.unshift(node.val);
        for (const child of node.children) {
            stack.push(child);
        }
    }

    return result;
};