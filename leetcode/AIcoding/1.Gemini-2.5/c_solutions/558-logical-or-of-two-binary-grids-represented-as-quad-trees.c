#include <stdlib.h>
#include <stdbool.h>

struct Node* intersect(struct Node* quadTree1, struct Node* quadTree2) {
    if (quadTree1->isLeaf && quadTree1->val) {
        return quadTree1;
    }
    if (quadTree2->isLeaf && quadTree2->val) {
        return quadTree2;
    }

    if (quadTree1->isLeaf && !quadTree1->val) {
        return quadTree2;
    }
    if (quadTree2->isLeaf && !quadTree2->val) {
        return quadTree1;
    }

    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->isLeaf = false;

    newNode->topLeft = intersect(quadTree1->topLeft, quadTree2->topLeft);
    newNode->topRight = intersect(quadTree1->topRight, quadTree2->topRight);
    newNode->bottomLeft = intersect(quadTree1->bottomLeft, quadTree2->bottomLeft);
    newNode->bottomRight = intersect(quadTree1->bottomRight, quadTree2->bottomRight);

    if (newNode->topLeft->isLeaf && newNode->topRight->isLeaf &&
        newNode->bottomLeft->isLeaf && newNode->bottomRight->isLeaf &&
        newNode->topLeft->val == newNode->topRight->val &&
        newNode->topLeft->val == newNode->bottomLeft->val &&
        newNode->topLeft->val == newNode->bottomRight->val) {

        newNode->isLeaf = true;
        newNode->val = newNode->topLeft->val;
        newNode->topLeft = NULL;
        newNode->topRight = NULL;
        newNode->bottomLeft = NULL;
        newNode->bottomRight = NULL;
    }

    return newNode;
}