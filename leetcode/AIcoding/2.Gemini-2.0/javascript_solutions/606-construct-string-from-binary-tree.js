var tree2str = function(root) {
    if (!root) return "";
    let str = root.val.toString();
    if (root.left || root.right) {
        str += "(" + tree2str(root.left) + ")";
    }
    if (root.right) {
        str += "(" + tree2str(root.right) + ")";
    }
    return str;
};