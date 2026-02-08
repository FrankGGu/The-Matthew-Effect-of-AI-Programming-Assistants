class Solution {
public:
    Node* flatten(Node* head) {
        if (!head) {
            return head;
        }

        flattenDFS(head); 
        return head;
    }

private:
    Node* flattenDFS(Node* node) {
        Node* curr = node;
        Node* tail = node; 

        while (curr) {
            tail = curr; 

            if (curr->child) {
                Node* next_node = curr->next; 

                curr->next = curr->child;
                curr->child->prev = curr;

                Node* child_tail = flattenDFS(curr->child);

                child_tail->next = next_node;
                if (next_node) {
                    next_node->prev = child_tail;
                }

                curr->child = nullptr;

                curr = child_tail; 
            }
            curr = curr->next;
        }
        return tail; 
    }
};