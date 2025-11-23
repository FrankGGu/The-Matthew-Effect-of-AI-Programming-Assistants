#include <vector>
#include <queue>
#include <functional>

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
public:
    struct CompareNodes {
        bool operator()(ListNode* a, ListNode* b) {
            return a->val > b->val;
        }
    };

    ListNode* mergeKLists(std::vector<ListNode*>& lists) {
        std::priority_queue<ListNode*, std::vector<ListNode*>, CompareNodes> pq;

        for (ListNode* list : lists) {
            if (list != nullptr) {
                pq.push(list);
            }
        }

        ListNode* dummyHead = new ListNode();
        ListNode* current = dummyHead;

        while (!pq.empty()) {
            ListNode* minNode = pq.top();
            pq.pop();

            current->next = minNode;
            current = current->next;

            if (minNode->next != nullptr) {
                pq.push(minNode->next);
            }
        }

        ListNode* result = dummyHead->next;
        delete dummyHead; 
        return result;
    }
};