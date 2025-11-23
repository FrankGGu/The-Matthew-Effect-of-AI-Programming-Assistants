#include <cstdlib>

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
private:
    ListNode* head;
public:
    Solution(ListNode* head) {
        this->head = head;
    }

    int getRandom() {
        int res = 0;
        int i = 1;
        ListNode* curr = head;
        while (curr) {
            if (rand() % i == 0) {
                res = curr->val;
            }
            curr = curr->next;
            i++;
        }
        return res;
    }
};