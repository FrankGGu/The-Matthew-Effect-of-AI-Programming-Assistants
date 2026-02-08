#include <iostream>
#include <vector>
#include <unordered_set>

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
    ListNode* head;
    ListNode* deleteNodes(ListNode* head, vector<int>& nums) {
        this->head = head;
        unordered_set<int> s(nums.begin(), nums.end());
        ListNode dummy(0);
        dummy.next = head;
        ListNode* prev = &dummy;
        while (prev->next) {
            if (s.find(prev->next->val) != s.end()) {
                prev->next = prev->next->next;
            } else {
                prev = prev->next;
            }
        }
        return dummy.next;
    }
};