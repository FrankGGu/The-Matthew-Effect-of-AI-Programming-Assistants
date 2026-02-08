#include <iostream>
#include <vector>
#include <stack>

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
    vector<int> nextLargerNode(ListNode* head) {
        vector<int> result;
        stack<pair<int, int>> st;         int index = 0;

        while (head) {
            while (!st.empty() && st.top().first < head->val) {
                auto [val, i] = st.top();
                st.pop();
                result[i] = head->val;
            }
            st.push({head->val, index});
            result.push_back(0);
            head = head->next;
            index++;
        }

        return result;
    }
};