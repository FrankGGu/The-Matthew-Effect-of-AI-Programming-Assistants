class FindElements {
    constructor(root) {
        this.recoveredValues = new Set();
        this._recover(root, 0);
    }

    _recover(node, val) {
        if (!node) {
            return;
        }
        this.recoveredValues.add(val);
        this._recover(node.left, 2 * val + 1);
        this._recover(node.right, 2 * val + 2);
    }

    find(target) {
        return this.recoveredValues.has(target);
    }
}