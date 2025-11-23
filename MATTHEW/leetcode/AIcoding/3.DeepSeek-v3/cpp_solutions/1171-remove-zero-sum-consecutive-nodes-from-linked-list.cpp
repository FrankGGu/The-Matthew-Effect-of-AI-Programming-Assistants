#include <unordered_map>
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
    ListNode* removeZeroSumSublists(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        unordered_map<int, ListNode*> prefixSumMap;
        int sum = 0;
        for (ListNode* curr = dummy; curr != nullptr; curr = curr->next) {
            sum += curr->val;
            prefixSumMap[sum] = curr;
        }
        sum = 0;
        for (ListNode* curr = dummy; curr != nullptr; curr = curr->next) {
            sum += curr->val;
            curr->next = prefixSumMap[sum]->next;
        }
        return dummy->next;
    }
};