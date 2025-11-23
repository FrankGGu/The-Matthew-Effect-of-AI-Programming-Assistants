class Solution {
public:
    int kItemsWithMaximumSum(int numOnes, int numZeros, int numNegOnes, int k) {
        int maxOnes = min(numOnes, k);
        int remainingK = k - maxOnes;
        return maxOnes - max(0, remainingK - numZeros);
    }
};