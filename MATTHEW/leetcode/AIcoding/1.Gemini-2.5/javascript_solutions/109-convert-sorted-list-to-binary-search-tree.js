var sortedListToBST = function(head) {
    if (!head) {
        return null;
    }

    let len = 0;
    let current = head;
    while (current) {
        len++;
        current = current.next;
    }

    let listPointer = head;

    function buildBST(start, end) {
        if (start > end) {
            return null;
        }

        const mid = Math.floor((start + end) / 2);

        const leftChild = buildBST(start, mid - 1);

        const root = new TreeNode(listPointer.val);
        root.left = leftChild;

        listPointer = listPointer.next;

        const rightChild = buildBST(mid + 1, end);
        root.right = rightChild;

        return root;
    }

    return buildBST(0, len - 1);
};