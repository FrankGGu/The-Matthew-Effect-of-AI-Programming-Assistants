#include <iostream>
#include <vector>

using namespace std;

class Node {
public:
    int val;
    Node* prev;
    Node* next;
    Node* child;
};

class Solution {
public:
    Node* flatten(Node* head) {
        if (!head) return nullptr;

        Node* current = head;

        while (current) {
            if (current->child) {
                Node* nextNode = current->next;
                Node* child = current->child;

                                current->next = child;
                child->prev = current;

                                Node* tail = child;
                while (tail->next) {
                    tail = tail->next;
                }

                                tail->next = nextNode;
                if (nextNode) {
                    nextNode->prev = tail;
                }

                                current->child = nullptr;
            }

            current = current->next;
        }

        return head;
    }
};