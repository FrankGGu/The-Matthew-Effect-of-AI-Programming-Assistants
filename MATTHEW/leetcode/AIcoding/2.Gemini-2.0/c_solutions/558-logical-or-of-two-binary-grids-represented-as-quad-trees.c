#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    bool val;
    bool isLeaf;
    struct Node *topLeft;
    struct Node *topRight;
    struct Node *bottomLeft;
    struct Node *bottomRight;
};

struct Node* intersect(struct Node* quadTree1, struct Node* quadTree2) {
    if (quadTree1->isLeaf) {
        if (quadTree1->val) {
            return quadTree1;
        } else {
            return quadTree2;
        }
    }

    if (quadTree2->isLeaf) {
        if (quadTree2->val) {
            return quadTree2;
        } else {
            return quadTree1;
        }
    }

    struct Node* topLeft = intersect(quadTree1->topLeft, quadTree2->topLeft);
    struct Node* topRight = intersect(quadTree1->topRight, quadTree2->topRight);
    struct Node* bottomLeft = intersect(quadTree1->bottomLeft, quadTree2->bottomLeft);
    struct Node* bottomRight = intersect(quadTree1->bottomRight, quadTree2->bottomRight);

    if (topLeft->isLeaf && topRight->isLeaf && bottomLeft->isLeaf && bottomRight->isLeaf &&
        topLeft->val == topRight->val && topRight->val == bottomLeft->val && bottomLeft->val == bottomRight->val) {
        struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
        newNode->isLeaf = true;
        newNode->val = topLeft->val;
        newNode->topLeft = NULL;
        newNode->topRight = NULL;
        newNode->bottomLeft = NULL;
        newNode->bottomRight = NULL;
        return newNode;
    } else {
        struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
        newNode->isLeaf = false;
        newNode->topLeft = topLeft;
        newNode->topRight = topRight;
        newNode->bottomLeft = bottomLeft;
        newNode->bottomRight = bottomRight;
        return newNode;
    }
}