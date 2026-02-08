var getCoprimes = function(root, nums) {
    const gcd = (a, b) => {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    };

    const ans = new Array(nums.length);
    const stack = [];

    const dfs = (node, index) => {
        let ancestor = -1;
        let ancestorDepth = -1;

        for (let i = stack.length - 1; i >= 0; i--) {
            if (gcd(nums[index], nums[stack[i][0]]) === 1) {
                if (stack[i][1] > ancestorDepth) {
                    ancestorDepth = stack[i][1];
                    ancestor = stack[i][0];
                }
            }
        }

        ans[index] = ancestor;

        stack.push([index, stack.length]);

        if (node.left) {
            dfs(node.left, index + 1);
        }

        if (node.right) {
            dfs(node.right, index + (node.left ? 1 : 1));
        }

        stack.pop();
    };

    dfs(root, 0);
    return ans;
};