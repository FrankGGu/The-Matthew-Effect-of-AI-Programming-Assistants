var sortedArrayToBST = function(nums) {
    if (!nums || nums.length === 0) {
        return null;
    }

    const buildBST = (left, right) => {
        if (left > right) {
            return null;
        }

        const mid = Math.floor((left + right) / 2);
        const root = new TreeNode(nums[mid]);

        root.left = buildBST(left, mid - 1);
        root.right = buildBST(mid + 1, right);

        return root;
    };

    return buildBST(0, nums.length - 1);
};