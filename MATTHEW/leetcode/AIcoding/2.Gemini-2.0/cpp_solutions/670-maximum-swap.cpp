#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumSwap(int num) {
        string s = to_string(num);
        int n = s.length();
        int max_idx = n - 1;
        int idx1 = -1, idx2 = -1;

        for (int i = n - 2; i >= 0; i--) {
            if (s[i] < s[max_idx]) {
                idx1 = i;
                idx2 = max_idx;
            } else if (s[i] > s[max_idx]) {
                max_idx = i;
            }
        }

        if (idx1 != -1) {
            swap(s[idx1], s[idx2]);
            return stoi(s);
        }

        return num;
    }
};