class Solution {
public:
    bool canThreePartsEqualSum(vector<int>& A) {
        int total = accumulate(A.begin(), A.end(), 0);
        if (total % 3 != 0) return false;
        int target = total / 3, count = 0, currentSum = 0;

        for (int num : A) {
            currentSum += num;
            if (currentSum == target) {
                count++;
                currentSum = 0;
            }
        }
        return count >= 3;
    }
};