var componentValue = function(root) {
    let sum = 0;
    function dfs(node) {
        if (!node) return 0;
        sum += node.val;
        dfs(node.left);
        dfs(node.right);
    }
    dfs(root);

    function check(k) {
        let count = 0;
        function dfs2(node) {
            if (!node) return 0;
            let leftSum = dfs2(node.left);
            let rightSum = dfs2(node.right);
            let currentSum = leftSum + rightSum + node.val;

            if (currentSum === k) {
                count++;
                return 0;
            } else if (currentSum > k) {
                return node.val + leftSum + rightSum;
            } else {
                return currentSum;
            }
        }

        let remaining = dfs2(root);
        return count === sum / k - 1 && remaining === 0;
    }

    for (let i = 1; i <= sum; i++) {
        if (sum % i === 0) {
            if (check(i)) {
                return sum / i - 1;
            }
        }
    }

    return 0;
};