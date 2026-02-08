#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumCostSubstring(string s, string chars, vector<int>& vals) {
        vector<int> char_values(26);
        for (int i = 0; i < 26; ++i) {
            char_values[i] = i + 1;
        }
        for (int i = 0; i < chars.length(); ++i) {
            char_values[chars[i] - 'a'] = vals[i];
        }

        int max_cost = 0;
        int current_cost = 0;

        for (char c : s) {
            current_cost += char_values[c - 'a'];
            max_cost = max(max_cost, current_cost);
            current_cost = max(current_cost, 0);
        }

        return max_cost;
    }
};