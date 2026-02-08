var tree2str = function(root) {
    if (!root) return "";
    let left = tree2str(root.left);
    let right = tree2str(root.right);
    let result = `${root.val}`;
    if (left || right) {
        result += `(${left})`;
    }
    if (right) {
        result += `(${right})`;
    }
    return result;
};