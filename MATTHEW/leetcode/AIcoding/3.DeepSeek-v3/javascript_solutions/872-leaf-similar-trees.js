var leafSimilar = function(root1, root2) {
    const getLeaves = (node, leaves) => {
        if (!node) return;
        if (!node.left && !node.right) {
            leaves.push(node.val);
        }
        getLeaves(node.left, leaves);
        getLeaves(node.right, leaves);
    };

    const leaves1 = [];
    const leaves2 = [];
    getLeaves(root1, leaves1);
    getLeaves(root2, leaves2);

    if (leaves1.length !== leaves2.length) return false;
    for (let i = 0; i < leaves1.length; i++) {
        if (leaves1[i] !== leaves2[i]) return false;
    }
    return true;
};