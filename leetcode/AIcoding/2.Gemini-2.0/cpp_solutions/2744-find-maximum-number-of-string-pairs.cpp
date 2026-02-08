#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumNumberOfStringPairs(vector<string>& words) {
        int count = 0;
        int n = words.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (words[i].length() == 2 && words[j].length() == 2 &&
                    words[i][0] == words[j][1] && words[i][1] == words[j][0]) {
                    count++;
                }
            }
        }
        return count;
    }
};