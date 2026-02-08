#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> largeGroupPositions(string s) {
        vector<vector<int>> result;
        int start = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (i == s.length() - 1 || s[i] != s[i + 1]) {
                if (i - start + 1 >= 3) {
                    result.push_back({start, i});
                }
                start = i + 1;
            }
        }
        return result;
    }
};