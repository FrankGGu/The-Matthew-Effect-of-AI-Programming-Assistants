var findMode = function(root) {
    let modes = [];
    let maxCount = 0;
    let currentVal = null;
    let currentCount = 0;

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