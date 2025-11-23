#include <vector>
#include <algorithm>

class Solution {
public:
    int putMarbles(std::vector<int>& w, int k) {
        int n = w.size();
        std::vector<int> weights;
        for (int i = 0; i < n - 1; ++i) {
            weights.push_back(w[i] + w[i + 1]);
        }
        std::sort(weights.begin(), weights.end());
        int minWeight = 0, maxWeight = 0;
        for (int i = 0; i < k - 1; ++i) {
            minWeight += weights[i];
            maxWeight += weights[n - 2 - i];
        }
        return maxWeight - minWeight;
    }
};