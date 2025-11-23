var findMode = function(root) {
    let maxCount = 0;
    let currentCount = 0;
    let currentVal = null;
    let modes = [];

    function inorder(node) {
        if (!node) {
            return;
        }

        inorder(node.left);

        if (node.val === currentVal) {
            currentCount++;
        } else {
            currentVal = node.val;
            currentCount = 1;
        }

        if (currentCount > maxCount) {
            maxCount = currentCount;
            modes = [currentVal];
        } else if (currentCount === maxCount) {
            modes.push(currentVal);
        }

        inorder(node.right);
    }

    inorder(root);
    return modes;
};