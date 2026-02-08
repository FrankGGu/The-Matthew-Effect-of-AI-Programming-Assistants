#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string addSpaces(string s, vector<int>& spaces) {
        string res = "";
        int space_idx = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (space_idx < spaces.size() && i == spaces[space_idx]) {
                res += " ";
                space_idx++;
            }
            res += s[i];
        }
        return res;
    }
};