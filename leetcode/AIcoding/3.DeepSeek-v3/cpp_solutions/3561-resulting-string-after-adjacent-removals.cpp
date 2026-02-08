#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string resultString(string s, vector<int>& to_remove) {
        vector<bool> removed(s.size(), false);
        for (int pos : to_remove) {
            removed[pos] = true;
        }
        string res;
        for (int i = 0; i < s.size(); ++i) {
            if (!removed[i]) {
                res += s[i];
            }
        }
        return res;
    }
};