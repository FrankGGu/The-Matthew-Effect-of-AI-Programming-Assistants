var constructMaximumBinaryTree = function(nums) {
    if (!nums || nums.length === 0) {
        return null;
    }

    function build(start, end) {
        if (start > end) {
            return null;
        }

        let maxVal = -1;
        let maxIdx = -1;

        for (let i = start; i <= end; i++) {
            if (nums[i] > maxVal) {
                maxVal = nums[i];
                maxIdx = i;
            }
        }

        const root = new TreeNode(maxVal);
        root.left = build(start, maxIdx - 1);
        root.right = build(maxIdx + 1, end);

        return root;
    }

    return build(0, nums.length - 1);
};