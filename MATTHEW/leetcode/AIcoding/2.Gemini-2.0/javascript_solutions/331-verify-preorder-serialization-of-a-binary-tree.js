var isValidSerialization = function(preorder) {
    const nodes = preorder.split(',');
    let diff = 1;

    for (const node of nodes) {
        diff--;
        if (diff < 0) {
            return false;
        }
        if (node !== '#') {
            diff += 2;
        }
    }

    return diff === 0;
};