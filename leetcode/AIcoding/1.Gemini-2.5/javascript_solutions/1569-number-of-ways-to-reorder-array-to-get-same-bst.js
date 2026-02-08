const MOD = 10**9 + 7;
const MAX_N = 1001; // Max value of n for nums.length is 1000
const comb = Array(MAX_N).fill(0).map(() => Array(MAX_N).fill(0));

for (let i = 0; i < MAX_N; i++) {
    comb[i][0] = 1; // C(i, 0) is always 1
    for (let j = 1; j <= i; j++) {
        comb[i][j] = (comb[i-1][j-1] + comb[i-1][j]) % MOD;
    }
}

var numOfWays = function(nums) {

    // Recursive helper function to calculate ways for a given subarray
    function dfs(arr) {
        const n = arr.length;
        // Base case: If array has 0, 1, or 2 elements, there's only 1 way to form its BST.
        // For example, [x] forms a BST with root x.
        // [x, y] forms a BST with root x and y as its child (left or right).
        if (n <= 2) {
            return 1;
        }

        const root = arr[0];
        const leftSubtree = [];
        const rightSubtree = [];

        // Partition elements into left and right subtrees based on the root
        for (let i = 1; i < n; i++) {
            if (arr[i] < root) {
                leftSubtree.push(arr[i]);
            } else {
                rightSubtree.push(arr[i]);
            }
        }

        const numLeft = leftSubtree.length;
        const numRight = rightSubtree.length;

        // Calculate the number of ways to interleave elements of left and right subtrees.
        // This is C(n-1, numLeft), as we choose numLeft positions out of n-1 available
        // positions (excluding the root) for the left subtree elements.
        const combinations = comb[n - 1][numLeft];

        // Recursively calculate ways for left and right subtrees
        const waysLeft = dfs(leftSubtree);
        const waysRight = dfs(rightSubtree);

        // Total ways for the current subtree is the product of:
        // 1. Combinations to choose positions for left/right elements
        // 2. Ways to arrange elements within the left subtree
        // 3. Ways to arrange elements within the right subtree
        let result = (combinations * waysLeft) % MOD;
        result = (result * waysRight) % MOD;

        return result;
    }

    const totalWays = dfs(nums);

    // The problem asks for the number of ways *excluding* the original arrangement.
    // So, we subtract 1 from the total calculated ways.
    // Add MOD before taking modulo to handle cases where totalWays is 0 or 1.
    return (totalWays - 1 + MOD) % MOD;
};