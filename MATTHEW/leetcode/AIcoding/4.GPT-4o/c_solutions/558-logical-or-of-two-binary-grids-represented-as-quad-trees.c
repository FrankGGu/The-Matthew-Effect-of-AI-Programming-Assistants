struct Node* intersect(struct Node* quadTree1, struct Node* quadTree2) {
    if (quadTree1->isLeaf) {
        return quadTree1->val ? quadTree1 : quadTree2;
    }
    if (quadTree2->isLeaf) {
        return quadTree2->val ? quadTree2 : quadTree1;
    }

    struct Node* topLeft = intersect(quadTree1->topLeft, quadTree2->topLeft);
    struct Node* topRight = intersect(quadTree1->topRight, quadTree2->topRight);
    struct Node* bottomLeft = intersect(quadTree1->bottomLeft, quadTree2->bottomLeft);
    struct Node* bottomRight = intersect(quadTree1->bottomRight, quadTree2->bottomRight);

    if (topLeft->isLeaf && topRight->isLeaf && bottomLeft->isLeaf && bottomRight->isLeaf &&
        topLeft->val == topRight->val && topLeft->val == bottomLeft->val && topLeft->val == bottomRight->val) {
        return topLeft;
    }

    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->val = false;
    newNode->isLeaf = false;
    newNode->topLeft = topLeft;
    newNode->topRight = topRight;
    newNode->bottomLeft = bottomLeft;
    newNode->bottomRight = bottomRight;

    return newNode;
}