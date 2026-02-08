/**
 * Definition for a Node.
 * struct Node {
 *     int val;
 *     struct TreeNode *next;
 * };
 */

struct Node* insert(struct Node* head, int insertVal) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->val = insertVal;

    if (head == NULL) {
        newNode->next = newNode;
        return newNode;
    }

    struct Node* prev = head;
    struct Node* curr = head->next;

    while (curr != head) {
        if (prev->val <= insertVal && insertVal <= curr->val) {
            break;
        }
        if (prev->val > curr->val) {
            if (insertVal >= prev->val || insertVal <= curr->val) {
                break;
            }
        }
        prev = curr;
        curr = curr->next;
    }

    prev->next = newNode;
    newNode->next = curr;

    return head;
}