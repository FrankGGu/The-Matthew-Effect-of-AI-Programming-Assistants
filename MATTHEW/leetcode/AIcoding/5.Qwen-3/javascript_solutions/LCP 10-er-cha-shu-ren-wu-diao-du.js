function findMode(root) {
    let prev = null;
    let count = 0;
    let maxCount = 0;
    let result = [];

    function traverse(node) {
        if (!node) return;

        traverse(node.left);

        if (node.val === prev) {
            count++;
        } else {
            count = 1;
        }

        if (count > maxCount) {
            maxCount = count;
            result = [node.val];
        } else if (count === maxCount) {
            result.push(node.val);
        }

        prev = node.val;

        traverse(node.right);
    }

    traverse(root);
    return result;
}