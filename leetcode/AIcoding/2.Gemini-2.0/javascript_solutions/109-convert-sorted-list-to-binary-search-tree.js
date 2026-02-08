var sortedListToBST = function(head) {
    if (!head) return null;

    let array = [];
    let current = head;
    while (current) {
        array.push(current.val);
        current = current.next;
    }

    function buildBST(arr, start, end) {
        if (start > end) return null;

        let mid = Math.floor((start + end) / 2);
        let root = new TreeNode(arr[mid]);

        root.left = buildBST(arr, start, mid - 1);
        root.right = buildBST(arr, mid + 1, end);

        return root;
    }

    return buildBST(array, 0, array.length - 1);
};