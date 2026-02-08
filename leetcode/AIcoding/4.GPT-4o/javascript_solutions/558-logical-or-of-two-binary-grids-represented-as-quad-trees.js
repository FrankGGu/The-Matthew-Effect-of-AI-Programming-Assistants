class Node {
    constructor(val, isLeaf, topLeft, topRight, bottomLeft, bottomRight) {
        this.val = val;
        this.isLeaf = isLeaf;
        this.topLeft = topLeft;
        this.topRight = topRight;
        this.bottomLeft = bottomLeft;
        this.bottomRight = bottomRight;
    }
}

function intersect(quadrant1, quadrant2) {
    if (quadrant1.isLeaf) {
        return quadrant1.val ? quadrant1 : quadrant2;
    }
    if (quadrant2.isLeaf) {
        return quadrant2.val ? quadrant2 : quadrant1;
    }
    const topLeft = intersect(quadrant1.topLeft, quadrant2.topLeft);
    const topRight = intersect(quadrant1.topRight, quadrant2.topRight);
    const bottomLeft = intersect(quadrant1.bottomLeft, quadrant2.bottomLeft);
    const bottomRight = intersect(quadrant1.bottomRight, quadrant2.bottomRight);

    if (topLeft.isLeaf && topRight.isLeaf && bottomLeft.isLeaf && bottomRight.isLeaf &&
        topLeft.val === topRight.val && topLeft.val === bottomLeft.val && topLeft.val === bottomRight.val) {
        return new Node(topLeft.val, true);
    }

    return new Node(1, false, topLeft, topRight, bottomLeft, bottomRight);
}

var intersectQuadTrees = function(quadrant1, quadrant2) {
    return intersect(quadrant1, quadrant2);
};