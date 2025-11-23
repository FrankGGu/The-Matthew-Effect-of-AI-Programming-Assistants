var closestNodes = function(root, queries) {
    const nums = [];
    function inorder(node) {
        if (!node) return;
        inorder(node.left);
        nums.push(node.val);
        inorder(node.right);
    }
    inorder(root);

    const result = [];
    for (const query of queries) {
        let lower = -1;
        let upper = -1;

        let low = 0;
        let high = nums.length - 1;

        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (nums[mid] <= query) {
                lower = nums[mid];
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        low = 0;
        high = nums.length - 1;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (nums[mid] >= query) {
                upper = nums[mid];
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        result.push([lower, upper]);
    }

    return result;
};