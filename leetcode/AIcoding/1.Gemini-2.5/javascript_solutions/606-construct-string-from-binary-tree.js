var tree2str = function(root) {
    if (!root) {
        return "";
    }

    let result = root.val.toString();

    let leftPart = "";
    let rightPart = "";

    if (root.left) {
        leftPart = "(" + tree2str(root.left) + ")";
    } else if (root.right) { 
        // If left child is null but right child exists, 
        // we must output an empty pair of parentheses for the left child.
        leftPart = "()";
    }

    if (root.right) {
        rightPart = "(" + tree2str(root.right) + ")";
    }
    // If a right child is null, we should not output the empty parentheses pair for the right child.

    return result + leftPart + rightPart;
};