var closestNodes = function(root, queries) {
    const values = [];
    function inorder(node) {
        if (!node) return;
        inorder(node.left);
        values.push(node.val);
        inorder(node.right);
    }
    inorder(root);

    const result = [];
    for (const q of queries) {
        let left = 0, right = values.length - 1;
        let min = -1, max = -1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (values[mid] === q) {
                min = q;
                max = q;
                break;
            } else if (values[mid] < q) {
                min = values[mid];
                left = mid + 1;
            } else {
                max = values[mid];
                right = mid - 1;
            }
        }
        result.push([min, max]);
    }
    return result;
};