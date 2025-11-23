/**
 * Definition for a QuadTree node.
 * struct Node {
 *     int val;
 *     int isLeaf;
 *     struct Node* topLeft;
 *     struct Node* topRight;
 *     struct Node* bottomLeft;
 *     struct Node* bottomRight;
 * };
 */

struct Node* createNode(int val, int isLeaf) {
    struct Node* node = (struct Node*)malloc(sizeof(struct Node));
    node->val = val;
    node->isLeaf = isLeaf;
    node->topLeft = NULL;
    node->topRight = NULL;
    node->bottomLeft = NULL;
    node->bottomRight = NULL;
    return node;
}

struct Node* intersect(struct Node* quadTree1, struct Node* quadTree2) {
    if (quadTree1->isLeaf) {
        if (quadTree1->val) {
            return createNode(1, 1);
        }
        return quadTree2;
    }
    if (quadTree2->isLeaf) {
        if (quadTree2->val) {
            return createNode(1, 1);
        }
        return quadTree1;
    }

    struct Node* topLeft = intersect(quadTree1->topLeft, quadTree2->topLeft);
    struct Node* topRight = intersect(quadTree1->topRight, quadTree2->topRight);
    struct Node* bottomLeft = intersect(quadTree1->bottomLeft, quadTree2->bottomLeft);
    struct Node* bottomRight = intersect(quadTree1->bottomRight, quadTree2->bottomRight);

    if (topLeft->isLeaf && topRight->isLeaf && bottomLeft->isLeaf && bottomRight->isLeaf &&
        topLeft->val == topRight->val && topRight->val == bottomLeft->val && bottomLeft->val == bottomRight->val) {
        int val = topLeft->val;
        free(topLeft);
        free(topRight);
        free(bottomLeft);
        free(bottomRight);
        return createNode(val, 1);
    }

    struct Node* node = createNode(0, 0);
    node->topLeft = topLeft;
    node->topRight = topRight;
    node->bottomLeft = bottomLeft;
    node->bottomRight = bottomRight;
    return node;
}