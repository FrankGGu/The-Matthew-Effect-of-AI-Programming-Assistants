#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int earliestFullBloom(vector<int>& plantTime, vector<int>& growTime) {
        int n = plantTime.size();
        vector<int> indices(n);
        for (int i = 0; i < n; ++i) {
            indices[i] = i;
        }

        sort(indices.begin(), indices.end(), [&](int i, int j) {
            return growTime[i] > growTime[j];
        });

        int currentPlantTime = 0;
        int maxBloomTime = 0;

        for (int i = 0; i < n; ++i) {
            int index = indices[i];
            currentPlantTime += plantTime[index];
            maxBloomTime = max(maxBloomTime, currentPlantTime + growTime[index]);
        }

        return maxBloomTime;
    }
};