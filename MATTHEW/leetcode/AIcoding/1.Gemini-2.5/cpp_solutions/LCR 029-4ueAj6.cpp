class Solution {
public:
    Node* insert(Node* head, int insertVal) {
        Node* newNode = new Node(insertVal);

        if (head == nullptr) {
            newNode->next = newNode;
            return newNode;
        }

        Node* prev = head;
        Node* curr = head->next;
        bool inserted = false;

        do {
            if (prev->val <= insertVal && insertVal <= curr->val) {
                // Case 1: Insert in the middle of a sorted segment
                inserted = true;
            } else if (prev->val > curr->val) {
                // Case 2: Found the "dip" where the list wraps around (e.g., 5 -> 1)
                // Insert if insertVal is greater than the max (prev) or smaller than the min (curr)
                if (insertVal >= prev->val || insertVal <= curr->val) {
                    inserted = true;
                }
            }

            if (inserted) {
                prev->next = newNode;
                newNode->next = curr;
                return head;
            }

            prev = curr;
            curr = curr->next;
        } while (prev != head);

        // If we reach here, it means all elements in the list are the same (e.g., 3->3->3)
        // or there was only one element and no specific insertion point was found.
        // In this case, we just insert the new node anywhere (e.g., after prev, which is head)
        prev->next = newNode;
        newNode->next = curr;
        return head;
    }
};