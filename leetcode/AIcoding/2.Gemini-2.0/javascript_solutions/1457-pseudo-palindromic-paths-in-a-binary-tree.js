var pseudoPalindromicPaths  = function(root) {
    let count = 0;

    function isPseudoPalindrome(freq) {
        let oddCount = 0;
        for (let i = 1; i <= 9; i++) {
            if (freq[i] % 2 !== 0) {
                oddCount++;
            }
        }
        return oddCount <= 1;
    }

    function dfs(node, freq) {
        if (!node) {
            return;
        }

        freq[node.val]++;

        if (!node.left && !node.right) {
            if (isPseudoPalindrome(freq)) {
                count++;
            }
        } else {
            if (node.left) {
                dfs(node.left, {...freq});
            }
            if (node.right) {
                dfs(node.right, {...freq});
            }
        }
    }

    dfs(root, Array(10).fill(0));
    return count;
};