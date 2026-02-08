#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxTotalFruits(vector<vector<int>>& fruits, int startPos, int k) {
        int n = fruits.size();
        int left = 0;
        int right = 0;
        int currentSum = 0;
        int maxFruits = 0;

        while (right < n) {
            currentSum += fruits[right][1];

            while (left <= right && distance(fruits[left][0], fruits[right][0], startPos) > k) {
                currentSum -= fruits[left][1];
                left++;
            }

            maxFruits = max(maxFruits, currentSum);
            right++;
        }

        return maxFruits;
    }

private:
    int distance(int leftPos, int rightPos, int startPos) {
        return min(abs(startPos - leftPos) + abs(rightPos - leftPos), abs(startPos - rightPos) + abs(rightPos - leftPos));
    }
};