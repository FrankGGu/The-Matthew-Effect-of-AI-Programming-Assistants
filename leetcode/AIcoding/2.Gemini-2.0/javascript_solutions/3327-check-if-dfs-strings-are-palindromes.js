var checkDFSStringsArePalindromes = function(s) {
    function dfs(node, path) {
        if (!node) {
            let str = path.join('');
            let reversedStr = str.split('').reverse().join('');
            return str === reversedStr;
        }

        return dfs(node.left, path.concat(node.val)) && dfs(node.right, path.concat(node.val));
    }

    function isPalindrome(str) {
        let left = 0;
        let right = str.length - 1;
        while (left < right) {
            if (str[left] !== str[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    function getAllPaths(root) {
        let paths = [];

        function traverse(node, currentPath) {
            if (!node) {
                if (currentPath.length > 0) {
                    paths.push(currentPath.join(''));
                }
                return;
            }

            currentPath.push(node.val);
            traverse(node.left, [...currentPath]);
            traverse(node.right, [...currentPath]);
            currentPath.pop();
        }

        traverse(root, []);
        return paths;
    }

    if (!s) return true;

    let paths = getAllPaths(s);

    if(paths.length === 0) return true;

    for(let path of paths) {
        if(!isPalindrome(path)) return false;
    }

    return true;
};