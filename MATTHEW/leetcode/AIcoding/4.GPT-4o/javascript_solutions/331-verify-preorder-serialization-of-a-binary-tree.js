var isValidSerialization = function(preorder) {
    let nodes = preorder.split(',');
    let diff = 1;

    for (let i = 0; i < nodes.length; i++) {
        if (--diff < 0) return false;
        if (nodes[i] !== '#') diff += 2;
    }

    return diff === 0;
};