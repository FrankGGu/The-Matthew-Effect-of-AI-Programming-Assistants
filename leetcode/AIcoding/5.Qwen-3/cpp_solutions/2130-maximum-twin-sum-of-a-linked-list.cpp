#include <iostream>
#include <vector>
#include <cmath>

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
    int pairSum(ListNode* head) {
        vector<int> values;
        while (head) {
            values.push_back(head->val);
            head = head->next;
        }

        int n = values.size();
        int maxSum = 0;
        for (int i = 0; i < n / 2; ++i) {
            maxSum = max(maxSum, values[i] + values[n - 1 - i]);
        }

        return maxSum;
    }
};