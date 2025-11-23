function sortedListToBST(head) {
    if (!head) return null;

    let getListSize = (node) => {
        let size = 0;
        while (node) {
            size++;
            node = node.next;
        }
        return size;
    };

    let buildTree = (left, right) => {
        if (left > right) return null;
        let mid = Math.floor((left + right) / 2);

        let leftChild = buildTree(left, mid - 1);

        let root = new TreeNode(head.val);
        root.left = leftChild;

        head = head.next;

        root.right = buildTree(mid + 1, right);
        return root;
    };

    let size = getListSize(head);
    return buildTree(0, size - 1);
}