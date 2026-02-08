#include <vector>
#include <algorithm>

class Solution {
public:
    int eliminateMaximum(std::vector<int>& dist, std::vector<int>& speed) {
        int n = dist.size();
        std::vector<float> time(n);
        for (int i = 0; i < n; ++i) {
            time[i] = static_cast<float>(dist[i]) / speed[i];
        }
        std::sort(time.begin(), time.end());
        for (int i = 0; i < n; ++i) {
            if (time[i] <= i) {
                return i;
            }
        }
        return n;
    }
};