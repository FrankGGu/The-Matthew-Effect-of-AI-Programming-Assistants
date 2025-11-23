#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool digitCount(string num) {
        vector<int> counts(10, 0);
        for (char c : num) {
            counts[c - '0']++;
        }

        for (int i = 0; i < num.length(); ++i) {
            if (counts[i] != (num[i] - '0')) {
                return false;
            }
        }

        return true;
    }
};