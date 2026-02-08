#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int captureForts(vector<int>& forts) {
        int n = forts.size();
        int max_len = 0;
        int last_one = -1;
        int last_minus_one = -1;

        for (int i = 0; i < n; ++i) {
            if (forts[i] == 1) {
                if (last_minus_one != -1) {
                    max_len = max(max_len, i - last_minus_one - 1);
                }
                last_one = i;
            } else if (forts[i] == -1) {
                if (last_one != -1) {
                    max_len = max(max_len, i - last_one - 1);
                }
                last_minus_one = i;
            }
        }

        return max_len;
    }
};