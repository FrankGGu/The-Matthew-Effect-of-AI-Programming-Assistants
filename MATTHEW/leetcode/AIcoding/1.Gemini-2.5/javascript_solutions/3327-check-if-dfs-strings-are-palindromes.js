function solve(root) {
    function isPalindrome(s) {
        let left = 0;
        let right = s.length - 1;
        while (left < right) {
            if (s[left] !== s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    if (!root) {
        return true;
    }

    let allPathsArePalindromes = true;

    function dfs(node, currentPathString) {
        if (!allPathsArePalindromes) {
            return;
        }

        currentPathString += node.val;

        if (!node.left && !node.right) {
            if (!isPalindrome(currentPathString)) {
                allPathsArePalindromes = false;
            }
            return;
        }

        if (node.left) {
            dfs(node.left, currentPathString);
        }
        if (node.right) {
            dfs(node.right, currentPathString);
        }
    }

    dfs(root, "");
    return allPathsArePalindromes;
}