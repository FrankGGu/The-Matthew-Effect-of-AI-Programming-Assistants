class Solution {
public:
    ListNode* mergeKLists(vector<ListNode*>& lists) {
        auto cmp = [](ListNode* a, ListNode* b) {
            return a->val > b->val;
        };
        priority_queue<ListNode*, vector<ListNode*>, decltype(cmp)> min_heap(cmp);

        for (ListNode* list : lists) {
            if (list) {
                min_heap.push(list);
            }
        }

        ListNode dummy(0);
        ListNode* tail = &dummy;

        while (!min_heap.empty()) {
            ListNode* node = min_heap.top();
            min_heap.pop();
            tail->next = node;
            tail = tail->next;
            if (node->next) {
                min_heap.push(node->next);
            }
        }

        return dummy.next;
    }
};