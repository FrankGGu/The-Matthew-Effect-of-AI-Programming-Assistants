var subtreeInversionSum = function(root) {
    const result = [];

    function getInversionSum(node) {
        if (!node) {
            return 0;
        }

        let count = 0;
        const arr = [];

        function inorder(n) {
            if (!n) return;
            inorder(n.left);
            arr.push(n.val);
            inorder(n.right);
        }

        inorder(node);

        for (let i = 0; i < arr.length; i++) {
            for (let j = i + 1; j < arr.length; j++) {
                if (arr[i] > arr[j]) {
                    count++;
                }
            }
        }
        return count;
    }

    function traverse(node) {
        if (!node) {
            return;
        }

        result.push(getInversionSum(node));
        traverse(node.left);
        traverse(node.right);
    }

    traverse(root);
    return result;
};