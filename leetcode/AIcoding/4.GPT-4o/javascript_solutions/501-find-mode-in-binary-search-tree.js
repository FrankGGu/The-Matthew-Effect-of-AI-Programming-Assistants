var findMode = function(root) {
    const count = {};
    let maxCount = 0;
    let modes = [];

    const inorder = (node) => {
        if (!node) return;
        inorder(node.left);
        count[node.val] = (count[node.val] || 0) + 1;
        if (count[node.val] > maxCount) {
            maxCount = count[node.val];
            modes = [node.val];
        } else if (count[node.val] === maxCount) {
            modes.push(node.val);
        }
        inorder(node.right);
    };

    inorder(root);
    return modes;
};