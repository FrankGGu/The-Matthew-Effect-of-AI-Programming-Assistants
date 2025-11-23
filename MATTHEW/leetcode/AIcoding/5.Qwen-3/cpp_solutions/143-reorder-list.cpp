#include <iostream>
#include <vector>
#include <algorithm>
#include <stack>
#include <queue>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
public:
    void reorderList(ListNode* head) {
        if (!head || !head->next || !head->next->next) return;

        ListNode* slow = head;
        ListNode* fast = head;
        while (fast && fast->next) {
            slow = slow->next;
            fast = fast->next->next;
        }

        stack<ListNode*> st;
        ListNode* curr = slow->next;
        while (curr) {
            st.push(curr);
            curr = curr->next;
        }

        curr = head;
        while (!st.empty()) {
            ListNode* temp = st.top();
            st.pop();
            temp->next = curr->next;
            curr->next = temp;
            curr = temp->next;
        }
    }
};