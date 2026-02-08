class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = null;
        this.right = null;
    }
}

class BST {
    constructor() {
        this.root = null;
    }

    add(val) {
        if (!this.root) {
            this.root = new TreeNode(val);
            return;
        }

        let curr = this.root;
        while (true) {
            if (val < curr.val) {
                if (!curr.left) {
                    curr.left = new TreeNode(val);
                    return;
                }
                curr = curr.left;
            } else if (val > curr.val) {
                if (!curr.right) {
                    curr.right = new TreeNode(val);
                    return;
                }
                curr = curr.right;
            } else {
                // Value already exists, do nothing (or handle counts if needed for multiset)
                return;
            }
        }
    }

    // Finds the largest value less than or equal to target
    findFloor(target) {
        let floor = null;
        let curr = this.root;
        while (curr) {
            if (curr.val === target) {
                return curr.val;
            } else if (curr.val < target) {
                floor = curr.val; // This could be a potential floor
                curr = curr.right; // Try to find a larger floor
            } else { // curr.val > target
                curr = curr.left; // Target is smaller, go left
            }
        }
        return floor;
    }

    // Finds the smallest value greater than or equal to target
    findCeil(target) {
        let ceil = null;
        let curr = this.root;
        while (curr) {
            if (curr.val === target) {
                return curr.val;
            } else if (curr.val > target) {
                ceil = curr.val; // This could be a potential ceil
                curr = curr.left; // Try to find a smaller ceil
            } else { // curr.val < target
                curr = curr.right; // Target is larger, go right
            }
        }
        return ceil;
    }

    isEmpty() {
        return this.root === null;
    }
}

var minAbsoluteDifference = function(nums, x) {
    let minDiff = Infinity;
    const bst = new BST();

    for (let i = 0; i < nums.length; i++) {
        // We are looking for pairs (nums[i], nums[j]) such that |i - j| >= x.
        // This means j <= i - x or j >= i + x.
        // As we iterate `i` from left to right, we add `nums[i - x]` to our set
        // of candidates for `nums[j]` where `j <= i - x`.
        if (i >= x) {
            bst.add(nums[i - x]);
        }

        // If there are elements in the BST (candidates for nums[j])
        // that satisfy the index constraint, find the closest one to nums[i].
        if (!bst.isEmpty()) {
            const currentNum = nums[i];

            // Find floor: largest element in BST <= currentNum
            const floorVal = bst.findFloor(currentNum);
            if (floorVal !== null) {
                minDiff = Math.min(minDiff, Math.abs(currentNum - floorVal));
            }

            // Find ceil: smallest element in BST >= currentNum
            const ceilVal = bst.findCeil(currentNum);
            if (ceilVal !== null) {
                minDiff = Math.min(minDiff, Math.abs(currentNum - ceilVal));
            }
        }
    }

    return minDiff;
};