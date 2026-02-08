var isSubStructure = function(A, B) {
    if (!A || !B) {
        return false;
    }

    return doesAContainB(A, B) || isSubStructure(A.left, B) || isSubStructure(A.right, B);
};

var doesAContainB = function(A, B) {
    if (!B) {
        return true;
    }
    if (!A) {
        return false;
    }
    if (A.val !== B.val) {
        return false;
    }

    return doesAContainB(A.left, B.left) && doesAContainB(A.right, B.right);
};