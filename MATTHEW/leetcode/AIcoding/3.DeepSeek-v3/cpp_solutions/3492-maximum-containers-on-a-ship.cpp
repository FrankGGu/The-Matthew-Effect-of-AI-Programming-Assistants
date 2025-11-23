#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumContainers(vector<int>& weights, int maxWeight) {
        sort(weights.begin(), weights.end());
        int count = 0;
        int currentWeight = 0;
        for (int w : weights) {
            if (currentWeight + w <= maxWeight) {
                currentWeight += w;
                count++;
            } else {
                break;
            }
        }
        return count;
    }
};