#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumValue(vector<string>& strs) {
        int maxValue = 0;
        for (const string& str : strs) {
            int value = all_of(str.begin(), str.end(), ::isdigit) ? stoi(str) : str.size();
            maxValue = max(maxValue, value);
        }
        return maxValue;
    }
};