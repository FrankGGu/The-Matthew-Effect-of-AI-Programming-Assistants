class Solution {
public:
    vector<int> nextLargerNodes(ListNode* head) {
        vector<int> result;
        stack<pair<int, int>> s; 
        for (int i = 0; head; head = head->next, i++) {
            result.push_back(0);
            while (!s.empty() && s.top().first < head->val) {
                result[s.top().second] = head->val;
                s.pop();
            }
            s.push({head->val, i});
        }
        return result;
    }
};