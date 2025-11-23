class Solution {
public:
    int findMinimumImpossibleOR(vector<int>& A) {
        unordered_set<int> seen(A.begin(), A.end());
        int result = 1;
        while (seen.count(result)) {
            result++;
        }
        return result;
    }
};