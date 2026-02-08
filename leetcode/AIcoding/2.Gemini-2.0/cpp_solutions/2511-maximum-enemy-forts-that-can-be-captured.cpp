#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int captureForts(vector<int>& forts) {
        int n = forts.size();
        int max_captured = 0;
        int last_non_zero = -1;

        for (int i = 0; i < n; ++i) {
            if (forts[i] != 0) {
                if (last_non_zero != -1 && forts[i] != forts[last_non_zero]) {
                    int captured = 0;
                    for (int j = last_non_zero + 1; j < i; ++j) {
                        if (forts[j] == 0) {
                            captured++;
                        } else {
                            captured = 0;
                            break;
                        }
                    }
                    max_captured = max(max_captured, captured);
                }
                last_non_zero = i;
            }
        }

        return max_captured;
    }
};