using namespace std;

class Solution {
public:
    int numSubmatrixSumTarget(vector<vector<int>>& matrix, int target) {
        int m = matrix.size();
        int n = matrix[0].size();
        int count = 0;

        for (int i = 0; i < m; i++) {
            vector<int> colSum(n, 0);
            for (int j = i; j < m; j++) {
                for (int k = 0; k < n; k++) {
                    colSum[k] += matrix[j][k];
                }
                unordered_map<int, int> prefixSumMap;
                prefixSumMap[0] = 1;
                int currSum = 0;
                for (int k = 0; k < n; k++) {
                    currSum += colSum[k];
                    if (prefixSumMap.find(currSum - target) != prefixSumMap.end()) {
                        count += prefixSumMap[currSum - target];
                    }
                    prefixSumMap[currSum]++;
                }
            }
        }
        return count;
    }
};