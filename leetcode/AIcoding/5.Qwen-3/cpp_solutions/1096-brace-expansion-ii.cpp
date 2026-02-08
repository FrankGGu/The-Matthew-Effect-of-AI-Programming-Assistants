#include <iostream>
#include <vector>
#include <string>
#include <stack>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> braceExpansionII(string s) {
        vector<string> result;
        stack<vector<string>> st;
        vector<string> curr;
        int i = 0;
        while (i < s.size()) {
            if (s[i] == '{') {
                st.push(curr);
                curr.clear();
                ++i;
            } else if (s[i] == '}') {
                vector<string> top = st.top();
                st.pop();
                vector<string> temp;
                for (const string& t : top) {
                    for (const string& c : curr) {
                        temp.push_back(t + c);
                    }
                }
                curr = temp;
                ++i;
            } else if (s[i] == ',') {
                st.top().insert(st.top().end(), curr.begin(), curr.end());
                curr.clear();
                ++i;
            } else {
                string ch(1, s[i]);
                curr.push_back(ch);
                ++i;
            }
        }
        return curr;
    }
};