#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestWPI(vector<int>& hours) {
        int n = hours.size();
        vector<int> score(n);
        for (int i = 0; i < n; ++i) {
            score[i] = (hours[i] > 8) ? 1 : -1;
        }

        int maxLen = 0;
        int currentSum = 0;
        unordered_map<int, int> sumToIndex;

        for (int i = 0; i < n; ++i) {
            currentSum += score[i];

            if (currentSum > 0) {
                maxLen = i + 1;
            } else {
                if (sumToIndex.find(currentSum) == sumToIndex.end()) {
                    sumToIndex[currentSum] = i;
                }

                if (sumToIndex.find(currentSum - 1) != sumToIndex.end()) {
                    maxLen = max(maxLen, i - sumToIndex[currentSum - 1]);
                }
            }
        }

        return maxLen;
    }
};