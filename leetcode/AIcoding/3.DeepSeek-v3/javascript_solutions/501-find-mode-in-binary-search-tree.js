var findMode = function(root) {
    let currentVal = null;
    let currentCount = 0;
    let maxCount = 0;
    let modes = [];

    function inOrder(node) {
        if (!node) return;

        inOrder(node.left);

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

        inOrder(node.right);
    }

    inOrder(root);
    return modes;
};