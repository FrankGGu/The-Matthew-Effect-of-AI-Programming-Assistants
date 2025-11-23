#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countBalancedPermutations(int n) {
        vector<int> p(2 * n);
        for (int i = 0; i < 2 * n; ++i) {
            p[i] = i + 1;
        }

        int count = 0;
        do {
            bool balanced = true;
            for (int i = 0; i < 2 * n; ++i) {
                for (int j = i + 1; j < 2 * n; ++j) {
                    if (p[i] + p[j] == (i + 1) + (j + 1)) {
                        balanced = false;
                        break;
                    }
                }
                if (!balanced) break;
            }
            if (balanced) {
                count++;
            }
        } while (next_permutation(p.begin(), p.end()));

        return count;
    }
};