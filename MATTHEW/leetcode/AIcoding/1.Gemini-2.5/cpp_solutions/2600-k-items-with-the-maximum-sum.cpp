#include <algorithm>

class Solution {
public:
    int kItemsWithMaximumSum(int numOnes, int numZeros, int numNegOnes, int k) {
        int currentSum = 0;

        int takeOnes = std::min(k, numOnes);
        currentSum += takeOnes;
        k -= takeOnes;

        if (k > 0) {
            int takeZeros = std::min(k, numZeros);
            k -= takeZeros;
        }

        if (k > 0) {
            int takeNegOnes = std::min(k, numNegOnes);
            currentSum -= takeNegOnes;
            k -= takeNegOnes;
        }

        return currentSum;
    }
};