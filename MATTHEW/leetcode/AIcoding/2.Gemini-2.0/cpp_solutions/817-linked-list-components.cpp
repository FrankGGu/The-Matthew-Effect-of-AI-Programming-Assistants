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
    int numComponents(ListNode* head, vector<int>& nums) {
        unordered_set<int> s(nums.begin(), nums.end());
        int count = 0;
        bool in_component = false;

        while (head != nullptr) {
            if (s.count(head->val)) {
                if (!in_component) {
                    count++;
                    in_component = true;
                }
            } else {
                in_component = false;
            }
            head = head->next;
        }

        return count;
    }
};