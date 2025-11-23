var colorTree = function(root) {
    if (!root) return [0, 0];

    const left = colorTree(root.left);
    const right = colorTree(root.right);

    const color0 = left[1] + right[1];
    const color1 = Math.min(left[0], left[1]) + Math.min(right[0], right[1]) + 1;

    return [color0, color1];
};

var minColor = function(root) {
    const result = colorTree(root);
    return Math.min(result[0], result[1]);
};