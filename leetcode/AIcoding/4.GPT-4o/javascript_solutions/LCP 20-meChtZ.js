var numOfWays = function(nums) {
    const mod = 1e9 + 7;

    const count = (start, end, nums) => {
        let left = 0, right = 0;
        for (let num of nums) {
            if (num < start) left++;
            else if (num > end) right++;
        }
        return left + right;
    };

    const dfs = (nums) => {
        if (nums.length <= 2) return 1;

        const root = nums[0];
        const leftSubtree = nums.filter(x => x < root);
        const rightSubtree = nums.filter(x => x > root);

        const leftCount = dfs(leftSubtree);
        const rightCount = dfs(rightSubtree);
        const totalCount = leftCount * rightCount % mod;

        const comb = (n, k) => {
            if (k > n) return 0;
            let res = 1;
            for (let i = 0; i < k; i++) {
                res = (res * (n - i) % mod) * pow(i + 1, mod - 2) % mod;
            }
            return res;
        };

        return totalCount * comb(leftSubtree.length + rightSubtree.length, leftSubtree.length) % mod;
    };

    return (dfs(nums) - 1 + mod) % mod;
};