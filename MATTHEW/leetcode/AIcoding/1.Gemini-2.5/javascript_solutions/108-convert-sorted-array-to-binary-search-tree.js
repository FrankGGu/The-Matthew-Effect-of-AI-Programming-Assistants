var sortedArrayToBST = function(nums) {
    function convert(left, right) {
        if (left > right) {
            return null;
        }

        const mid = Math.floor((left + right) / 2);
        const root = new TreeNode(nums[mid]);

        root.left = convert(left, mid - 1);
        root.right = convert(mid + 1, right);

        return root;
    }

    return convert(0, nums.length - 1);
};