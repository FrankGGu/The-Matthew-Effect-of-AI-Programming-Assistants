#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minBooths(vector<string>& demand) {
        vector<int> maxCount(26, 0);
        for (const string& day : demand) {
            vector<int> currentCount(26, 0);
            for (char c : day) {
                currentCount[c - 'a']++;
            }
            for (int i = 0; i < 26; ++i) {
                maxCount[i] = max(maxCount[i], currentCount[i]);
            }
        }
        int total = 0;
        for (int count : maxCount) {
            total += count;
        }
        return total;
    }
};