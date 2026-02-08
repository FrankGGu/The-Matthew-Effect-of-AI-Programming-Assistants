class Solution {
private:
    Node* deepCopy(Node* node) {
        if (!node) {
            return nullptr;
        }
        if (node->isLeaf) {
            return new Node(node->val, true);
        } else {
            return new Node(false, false,
                            deepCopy(node->topLeft),
                            deepCopy(node->topRight),
                            deepCopy(node->bottomLeft),
                            deepCopy(node->bottomRight));
        }
    }

public:
    Node* intersect(Node* quad1, Node* quad2) {
        // Case 1: If quad1 is a leaf and its value is true, the OR result is true.
        // This region is entirely 1s, so ORing with anything results in 1s.
        if (quad1->isLeaf && quad1->val) {
            return new Node(true, true);
        }
        // Case 2: If quad2 is a leaf and its value is true, the OR result is true.
        // This region is entirely 1s, so ORing with anything results in 1s.
        if (quad2->isLeaf && quad2->val) {
            return new Node(true, true);
        }

        // At this point, we know:
        // - If quad1 is a leaf, its value must be false.
        // - If quad2 is a leaf, its value must be false.

        // Case 3: If quad1 is a leaf (and its value is false), the OR result is effectively quad2.
        // We need to return a new quad-tree identical to quad2.
        if (quad1->isLeaf && !quad1->val) {
            return deepCopy(quad2);
        }
        // Case 4: If quad2 is a leaf (and its value is false), the OR result is effectively quad1.
        // We need to return a new quad-tree identical to quad1.
        if (quad2->isLeaf && !quad2->val) {
            return deepCopy(quad1);
        }

        // Case 5: Both quad1 and quad2 are non-leaf nodes.
        // Recursively intersect their corresponding children.
        Node* topLeft = intersect(quad1->topLeft, quad2->topLeft);
        Node* topRight = intersect(quad1->topRight, quad2->topRight);
        Node* bottomLeft = intersect(quad1->bottomLeft, quad2->bottomLeft);
        Node* bottomRight = intersect(quad1->bottomRight, quad2->bottomRight);

        // After intersecting children, check if they can be merged into a single leaf node.
        // This happens if all four resulting children are leaf nodes and have the same value.
        if (topLeft->isLeaf && topRight->isLeaf && bottomLeft->isLeaf && bottomRight->isLeaf &&
            topLeft->val == topRight->val && topLeft->val == bottomLeft->val && topLeft->val == bottomRight->val) {
            // All children are identical leaves, so merge them into a single leaf.
            // The value of this new leaf will be the common value of its children.
            return new Node(topLeft->val, true);
        } else {
            // Cannot merge, return a new non-leaf node with the intersected children.
            return new Node(false, false, topLeft, topRight, bottomLeft, bottomRight);
        }
    }
};