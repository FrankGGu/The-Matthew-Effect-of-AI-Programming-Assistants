class Solution {
public:
    string robotWithString(string s) {
        string result;
        stack<char> stk;
        vector<int> count(26, 0);

        for (char c : s) {
            count[c - 'a']++;
        }

        for (char c : s) {
            stk.push(c);
            count[c - 'a']--;

            while (!stk.empty() && stk.top() <= 'a' + min_element(count.begin(), count.end()) - count.begin()) {
                result += stk.top();
                stk.pop();
            }
        }

        return result;
    }
};