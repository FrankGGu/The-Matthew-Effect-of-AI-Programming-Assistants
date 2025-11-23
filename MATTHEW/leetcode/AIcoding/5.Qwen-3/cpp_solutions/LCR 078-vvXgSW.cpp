#include <iostream>
#include <vector>
#include <queue>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution {
public:
    ListNode* mergeKLists(vector<ListNode*>& lists) {
        if (lists.empty()) return nullptr;

        priority_queue<pair<int, ListNode*>, vector<pair<int, ListNode*>>, greater<pair<int, ListNode*>>> minHeap;

        for (auto list : lists) {
            if (list) {
                minHeap.push({list->val, list});
            }
        }

        ListNode dummy(0);
        ListNode* current = &dummy;

        while (!minHeap.empty()) {
            auto top = minHeap.top();
            minHeap.pop();
            current->next = top.second;
            current = current->next;
            if (top.second->next) {
                minHeap.push({top.second->next->val, top.second->next});
            }
        }

        return dummy.next;
    }
};