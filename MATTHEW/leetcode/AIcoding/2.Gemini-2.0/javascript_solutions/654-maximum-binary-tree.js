var constructMaximumBinaryTree = function(nums) {
    if (!nums || nums.length === 0) {
        return null;
    }

    const findMaxIndex = (arr) => {
        let maxIndex = 0;
        for (let i = 1; i < arr.length; i++) {
            if (arr[i] > arr[maxIndex]) {
                maxIndex = i;
            }
        }
        return maxIndex;
    };

    const buildTree = (arr) => {
        if (!arr || arr.length === 0) {
            return null;
        }

        const maxIndex = findMaxIndex(arr);
        const root = new TreeNode(arr[maxIndex]);

        root.left = buildTree(arr.slice(0, maxIndex));
        root.right = buildTree(arr.slice(maxIndex + 1));

        return root;
    };

    return buildTree(nums);
};