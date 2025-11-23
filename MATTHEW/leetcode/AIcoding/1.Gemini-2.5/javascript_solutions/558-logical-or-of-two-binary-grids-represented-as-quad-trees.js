function intersect(quadTree1, quadTree2) {
    if (quadTree1.isLeaf && quadTree1.val === 1) {
        return new Node(1, true, null, null, null, null);
    }
    if (quadTree2.isLeaf && quadTree2.val === 1) {
        return new Node(1, true, null, null, null, null);
    }

    if (quadTree1.isLeaf && quadTree1.val === 0) {
        return quadTree2;
    }
    if (quadTree2.isLeaf && quadTree2.val === 0) {
        return quadTree1;
    }

    const topLeft = intersect(quadTree1.topLeft, quadTree2.topLeft);
    const topRight = intersect(quadTree1.topRight, quadTree2.topRight);
    const bottomLeft = intersect(quadTree1.bottomLeft, quadTree2.bottomLeft);
    const bottomRight = intersect(quadTree1.bottomRight, quadTree2.bottomRight);

    if (topLeft.isLeaf && topRight.isLeaf && bottomLeft.isLeaf && bottomRight.isLeaf &&
        topLeft.val === topRight.val && topLeft.val === bottomLeft.val && topLeft.val === bottomRight.val) {
        return new Node(topLeft.val, true, null, null, null, null);
    } else {
        return new Node(0, false, topLeft, topRight, bottomLeft, bottomRight);
    }
}