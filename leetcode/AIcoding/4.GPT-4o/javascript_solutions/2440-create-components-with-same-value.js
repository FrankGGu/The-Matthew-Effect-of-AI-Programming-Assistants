class Solution {
    constructor() {
        this.totalSum = 0;
        this.componentCount = 0;
        this.parent = new Map();
    }

    componentValue(root, target) {
        this.totalSum = this.dfs(root);
        if (this.totalSum % target !== 0) return 0;
        this.componentCount = this.totalSum / target;
        return this.canCreateComponents(root, target) ? this.componentCount - 1 : 0;
    }

    dfs(node) {
        if (!node) return 0;
        const leftSum = this.dfs(node.left);
        const rightSum = this.dfs(node.right);
        const currentSum = leftSum + rightSum + node.val;
        this.parent.set(node, currentSum);
        return currentSum;
    }

    canCreateComponents(node, target) {
        if (!node) return true;
        const currentValue = this.parent.get(node);
        if (currentValue === target) {
            this.componentCount--;
            return true;
        }
        return this.canCreateComponents(node.left, target) && this.canCreateComponents(node.right, target);
    }
}