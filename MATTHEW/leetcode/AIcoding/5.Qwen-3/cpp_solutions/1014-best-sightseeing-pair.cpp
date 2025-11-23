#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maxScoreSightseeing(int[] A, int ASize) {
        int maxPrev = A[0];
        int maxScore = INT_MIN;
        for (int i = 1; i < ASize; i++) {
            int currentScore = maxPrev - 1 + A[i];
            if (currentScore > maxScore) {
                maxScore = currentScore;
            }
            if (A[i] > maxPrev - 1) {
                maxPrev = A[i];
            }
        }
        return maxScore;
    }
};