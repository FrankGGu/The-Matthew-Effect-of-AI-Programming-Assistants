#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    Node* insert(Node* head, int insertVal) {
        if (head == nullptr) {
            Node* newNode = new Node(insertVal);
            newNode->next = newNode;
            return newNode;
        }

        Node* prev = head;
        Node* curr = head->next;
        bool inserted = false;

        while (true) {
            if (prev->val <= insertVal && curr->val >= insertVal) {
                prev->next = new Node(insertVal, curr);
                inserted = true;
                break;
            } else if (prev->val > curr->val) {
                if (insertVal >= prev->val || insertVal <= curr->val) {
                    prev->next = new Node(insertVal, curr);
                    inserted = true;
                    break;
                }
            }

            prev = curr;
            curr = curr->next;

            if (prev == head) {
                break;
            }
        }

        if (!inserted) {
            prev->next = new Node(insertVal, curr);
        }

        return head;
    }
};

struct Node {
    int val;
    Node* next;
    Node() : val(0), next(nullptr) {}
    Node(int x) : val(x), next(nullptr) {}
    Node(int x, Node* next) : val(x), next(next) {}
};