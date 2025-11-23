#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution {
public:
    int numComponents(ListNode* head, vector<int>& G) {
        unordered_set<int> setG(G.begin(), G.end());
        int count = 0;
        bool inComponent = false;
        while (head != nullptr) {
            if (setG.find(head->val) != setG.end()) {
                inComponent = true;
            } else {
                if (inComponent) {
                    count++;
                    inComponent = false;
                }
            }
            head = head->next;
        }
        if (inComponent) count++;
        return count;
    }
};