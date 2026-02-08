#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution {
public:
    void reorderList(ListNode* head) {
        if (!head || !head->next) return;

        vector<ListNode*> nodes;
        ListNode* current = head;
        while (current) {
            nodes.push_back(current);
            current = current->next;
        }

        int left = 0, right = nodes.size() - 1;
        while (left < right) {
            nodes[left]->next = nodes[right];
            left++;
            if (left >= right) break;
            nodes[right]->next = nodes[left];
            right--;
        }

        nodes[left]->next = nullptr;
    }
};