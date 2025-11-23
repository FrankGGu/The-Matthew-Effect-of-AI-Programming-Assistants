#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumBuckets(string sand) {
        int n = sand.size();
        int buckets = 0;
        vector<bool> placed(n, false);

        for (int i = 0; i < n; ++i) {
            if (sand[i] == '.') continue;

            if (i > 0 && sand[i - 1] == '.' && !placed[i - 1]) {
                buckets++;
                placed[i - 1] = true;
            } else if (i < n - 1 && sand[i + 1] == '.') {
                buckets++;
                placed[i + 1] = true;
            } else {
                return -1;
            }
        }

        return buckets;
    }
};