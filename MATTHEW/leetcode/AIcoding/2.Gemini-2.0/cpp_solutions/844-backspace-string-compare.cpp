#include <string>

using namespace std;

class Solution {
public:
    bool backspaceCompare(string s, string t) {
        string s_processed = "";
        string t_processed = "";

        for (char c : s) {
            if (c == '#') {
                if (!s_processed.empty()) {
                    s_processed.pop_back();
                }
            } else {
                s_processed.push_back(c);
            }
        }

        for (char c : t) {
            if (c == '#') {
                if (!t_processed.empty()) {
                    t_processed.pop_back();
                }
            } else {
                t_processed.push_back(c);
            }
        }

        return s_processed == t_processed;
    }
};