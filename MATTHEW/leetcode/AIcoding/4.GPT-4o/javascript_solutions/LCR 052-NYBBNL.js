class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var increasingBST = function(root) {
    const arr = [];
    const inorder = (node) => {
        if (node) {
            inorder(node.left);
            arr.push(node.val);
            inorder(node.right);
        }
    };
    inorder(root);

    const newRoot = new TreeNode(arr[0]);
    let current = newRoot;
    for (let i = 1; i < arr.length; i++) {
        current.right = new TreeNode(arr[i]);
        current = current.right;
    }
    return newRoot;
};