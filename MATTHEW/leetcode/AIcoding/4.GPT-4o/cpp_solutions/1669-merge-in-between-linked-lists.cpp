struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution {
public:
    ListNode* mergeInBetween(ListNode* list1, int a, int b, ListNode* list2) {
        ListNode* pre = list1;
        for (int i = 0; i < a - 1; ++i) {
            pre = pre->next;
        }
        ListNode* post = pre;
        for (int i = 0; i < b - a + 1; ++i) {
            post = post->next;
        }
        pre->next = list2;
        while (pre->next) {
            pre = pre->next;
        }
        pre->next = post;
        return list1;
    }
};