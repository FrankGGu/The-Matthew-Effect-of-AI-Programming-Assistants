#include <vector>
#include <queue>
#include <functional> // Required for std::greater if using default comparison for int, but custom struct is better for ListNode*

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x, next) {}
};

class Solution {
public:
    struct CompareNodes {
        bool operator()(ListNode* a, ListNode* b) {
            return a->val > b->val; // Min-heap based on node value
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
            ListNode* node = pq.top();
            pq.pop();

            current->next = node;
            current = current->next;

            if (node->next != nullptr) {
                pq.push(node->next);
            }
        }

        ListNode* result = dummyHead->next;
        delete dummyHead; // Clean up the dummy head
        return result;
    }
};