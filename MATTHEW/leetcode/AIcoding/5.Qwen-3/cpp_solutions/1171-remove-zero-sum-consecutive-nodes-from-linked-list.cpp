#include <iostream>
#include <vector>

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
    ListNode* removeZeroSumSubstrings(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* current = dummy;
        int prefixSum = 0;
        vector<int> prefixSums;
        vector<ListNode*> nodes;

        while (current) {
            prefixSum += current->val;
            prefixSums.push_back(prefixSum);
            nodes.push_back(current);
            current = current->next;
        }

        for (int i = 0; i < prefixSums.size(); ++i) {
            for (int j = i + 1; j < prefixSums.size(); ++j) {
                if (prefixSums[i] == prefixSums[j]) {
                    nodes[i]->next = nodes[j]->next;
                    break;
                }
            }
        }

        return dummy->next;
    }
};