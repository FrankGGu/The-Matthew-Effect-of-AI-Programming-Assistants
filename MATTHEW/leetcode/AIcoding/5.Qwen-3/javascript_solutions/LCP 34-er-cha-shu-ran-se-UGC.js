function dfs(node) {
    if (!node) return 0;
    return 1 + dfs(node.left) + dfs(node.right);
}

function getTargetCopy(original, cloned, target) {
    if (!original) return null;
    if (original === target) return cloned;
    const left = getTargetCopy(original.left, cloned.left, target);
    if (left) return left;
    return getTargetCopy(original.right, cloned.right, target);
}

function deleteNode(root, key) {
    if (!root) return null;
    if (key < root.val) {
        root.left = deleteNode(root.left, key);
        return root;
    } else if (key > root.val) {
        root.right = deleteNode(root.right, key);
        return root;
    } else {
        if (!root.left && !root.right) return null;
        if (!root.left) return root.right;
        if (!root.right) return root.left;
        const minNode = findMin(root.right);
        root.val = minNode.val;
        root.right = deleteNode(root.right, minNode.val);
        return root;
    }
}

function findMin(node) {
    while (node.left) {
        node = node.left;
    }
    return node;
}

function insertIntoBST(root, val) {
    if (!root) return new TreeNode(val);
    if (val < root.val) {
        root.left = insertIntoBST(root.left, val);
    } else {
        root.right = insertIntoBST(root.right, val);
    }
    return root;
}

function searchBST(root, val) {
    if (!root || root.val === val) return root;
    return val < root.val ? searchBST(root.left, val) : searchBST(root.right, val);
}

function trimBST(root, low, high) {
    if (!root) return null;
    if (root.val < low) return trimBST(root.right, low, high);
    if (root.val > high) return trimBST(root.left, low, high);
    root.left = trimBST(root.left, low, high);
    root.right = trimBST(root.right, low, high);
    return root;
}

function maxDepth(root) {
    if (!root) return 0;
    return 1 + Math.max(maxDepth(root.left), maxDepth(root.right));
}

function isSameTree(p, q) {
    if (!p && !q) return true;
    if (!p || !q) return false;
    return p.val === q.val && isSameTree(p.left, q.left) && isSameTree(p.right, q.right);
}

function levelOrder(root) {
    const result = [];
    if (!root) return result;
    const queue = [root];
    while (queue.length) {
        const levelSize = queue.length;
        const level = [];
        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            level.push(node.val);
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }
        result.push(level);
    }
    return result;
}

function invertTree(root) {
    if (!root) return null;
    const temp = root.left;
    root.left = root.right;
    root.right = temp;
    invertTree(root.left);
    invertTree(root.right);
    return root;
}

function buildTree(preorder, inorder) {
    const map = new Map();
    for (let i = 0; i < inorder.length; i++) {
        map.set(inorder[i], i);
    }
    let preIndex = 0;
    function helper(inStart, inEnd) {
        if (inStart > inEnd) return null;
        const rootVal = preorder[preIndex++];
        const root = new TreeNode(rootVal);
        const inIndex = map.get(rootVal);
        root.left = helper(inStart, inIndex - 1);
        root.right = helper(inIndex + 1, inEnd);
        return root;
    }
    return helper(0, inorder.length - 1);
}

function sortedArrayToBST(nums) {
    function helper(left, right) {
        if (left > right) return null;
        const mid = Math.floor((left + right) / 2);
        const node = new TreeNode(nums[mid]);
        node.left = helper(left, mid - 1);
        node.right = helper(mid + 1, right);
        return node;
    }
    return helper(0, nums.length - 1);
}

function hasPathSum(root, targetSum) {
    if (!root) return false;
    if (!root.left && !root.right) return targetSum === root.val;
    return hasPathSum(root.left, targetSum - root.val) || hasPathSum(root.right, targetSum - root.val);
}

function pathSum(root, targetSum) {
    const result = [];
    function dfs(node, path, sum) {
        if (!node) return;
        path.push(node.val);
        sum += node.val;
        if (!node.left && !node.right && sum === targetSum) {
            result.push([...path]);
        }
        dfs(node.left, path, sum);
        dfs(node.right, path, sum);
        path.pop();
    }
    dfs(root, [], 0);
    return result;
}

function lowestCommonAncestor(root, p, q) {
    if (!root) return null;
    if (root.val === p.val || root.val === q.val) return root;
    const left = lowestCommonAncestor(root.left, p, q);
    const right = lowestCommonAncestor(root.right, p, q);
    if (left && right) return root;
    return left || right;
}

function diameterOfBinaryTree(root) {
    let maxDiameter = 0;
    function dfs(node) {
        if (!node) return 0;
        const left = dfs(node.left);
        const right = dfs(node.right);
        maxDiameter = Math.max(maxDiameter, left + right);
        return 1 + Math.max(left, right);
    }
    dfs(root);
    return maxDiameter;
}

function isBalanced(root) {
    function dfs(node) {
        if (!node) return 0;
        const left = dfs(node.left);
        const right = dfs(node.right);
        if (left === -1 || right === -1 || Math.abs(left - right) > 1) return -1;
        return 1 + Math.max(left, right);
    }
    return dfs(root) !== -1;
}

function isSubtree(s, t) {
    function isSame(a, b) {
        if (!a && !b) return true;
        if (!a || !b) return false;
        return a.val === b.val && isSame(a.left, b.left) && isSame(a.right, b.right);
    }
    if (!s) return false;
    if (isSame(s, t)) return true;
    return isSubtree(s.left, t) || isSubtree(s.right, t);
}

function findMode(root) {
    const freqMap = {};
    let maxFreq = 0;
    let result = [];
    function dfs(node) {
        if (!node) return;
        freqMap[node.val] = (freqMap[node.val] || 0) + 1;
        maxFreq = Math.max(maxFreq, freqMap[node.val]);
        dfs(node.left);
        dfs(node.right);
    }
    dfs(root);
    for (const key in freqMap) {
        if (freqMap[key] === maxFreq) {
            result.push(Number(key));
        }
    }
    return result;
}

function findBottomLeftValue(root) {
    let leftVal = root.val;
    let maxDepth = 0;
    function dfs(node, depth) {
        if (!node) return;
        if (depth > maxDepth) {
            maxDepth = depth;
            leftVal = node.val;
        }
        dfs(node.left, depth + 1);
        dfs(node.right, depth + 1);
    }
    dfs(root, 0);
    return leftVal;
}

function findTilt(root) {
    let totalTilt = 0;
    function dfs(node) {
        if (!node) return 0;
        const left = dfs(node.left);
        const right = dfs(node.right);
        totalTilt += Math.abs(left - right);
        return left + right + node.val;
    }
    dfs(root);
    return totalTilt;
}

function findSecondMinimumValue(root) {
    let min1 = root.val;
    let min2 = Infinity;
    function dfs(node) {
        if (!node) return;
        if (node.val > min1 && node.val < min2) {
            min2 = node.val;
        } else if (node.val === min1) {
            dfs(node.left);
            dfs(node.right);
        }
    }
    dfs(root);
    return min2 === Infinity ? -1 : min2;
}

function rangeSumBST(root, low, high) {
    let sum = 0;
    function dfs(node)