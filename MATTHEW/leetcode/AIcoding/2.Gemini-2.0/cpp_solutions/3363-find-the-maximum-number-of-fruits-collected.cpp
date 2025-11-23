#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxTotalFruits(vector<vector<int>>& fruits, int startPos, int k) {
        int n = fruits.size();
        int left = 0, right = 0;
        int currentSum = 0;
        int maxFruits = 0;

        while (right < n) {
            currentSum += fruits[right][1];

            while (true) {
                int dist = 0;
                if (fruits[right][0] >= startPos && fruits[left][0] <= startPos) {
                    dist = min(abs(fruits[right][0] - startPos) + abs(fruits[left][0] - startPos), abs(fruits[left][0] - fruits[right][0]));
                } else if (fruits[right][0] >= startPos) {
                    dist = fruits[right][0] - fruits[left][0] + min(abs(fruits[right][0] - startPos), abs(fruits[left][0] - startPos));
                } else {
                    dist = fruits[right][0] - fruits[left][0] + min(abs(fruits[right][0] - startPos), abs(fruits[left][0] - startPos));
                }

                if (dist <= k) {
                    break;
                }

                currentSum -= fruits[left][1];
                left++;
            }

            maxFruits = max(maxFruits, currentSum);
            right++;
        }

        return maxFruits;
    }
};