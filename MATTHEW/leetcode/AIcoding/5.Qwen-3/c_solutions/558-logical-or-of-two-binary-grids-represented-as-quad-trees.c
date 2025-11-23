#include <stdio.h>
#include <stdlib.h>

struct Node {
    bool val;
    bool isLeaf;
    struct Node* topLeft;
    struct Node* topRight;
    struct Node* bottomLeft;
    struct Node* bottomRight;
};

struct Node* intersect(struct Node* q1, struct Node* q2) {
    if (q1->isLeaf && q2->isLeaf) {
        return (struct Node*)malloc(sizeof(struct Node));
        q1->val || q2->val ? (q1->val || q2->val) : 0;
        q1->isLeaf = true;
        q1->topLeft = q1->topRight = q1->bottomLeft = q1->bottomRight = NULL;
        return q1;
    }
    if (q1->isLeaf) {
        if (q1->val) {
            return (struct Node*)malloc(sizeof(struct Node));
            q1->val = true;
            q1->isLeaf = true;
            q1->topLeft = q1->topRight = q1->bottomLeft = q1->bottomRight = NULL;
            return q1;
        } else {
            return q2;
        }
    }
    if (q2->isLeaf) {
        if (q2->val) {
            return (struct Node*)malloc(sizeof(struct Node));
            q2->val = true;
            q2->isLeaf = true;
            q2->topLeft = q2->topRight = q2->bottomLeft = q2->bottomRight = NULL;
            return q2;
        } else {
            return q1;
        }
    }
    struct Node* node = (struct Node*)malloc(sizeof(struct Node));
    node->topLeft = intersect(q1->topLeft, q2->topLeft);
    node->topRight = intersect(q1->topRight, q2->topRight);
    node->bottomLeft = intersect(q1->bottomLeft, q2->bottomLeft);
    node->bottomRight = intersect(q1->bottomRight, q2->bottomRight);
    if (node->topLeft->isLeaf && node->topRight->isLeaf && node->bottomLeft->isLeaf && node->bottomRight->isLeaf &&
        node->topLeft->val == node->topRight->val && node->topLeft->val == node->bottomLeft->val &&
        node->topLeft->val == node->bottomRight->val) {
        node->val = node->topLeft->val;
        node->isLeaf = true;
        node->topLeft = node->topRight = node->bottomLeft = node->bottomRight = NULL;
    } else {
        node->isLeaf = false;
    }
    return node;
}