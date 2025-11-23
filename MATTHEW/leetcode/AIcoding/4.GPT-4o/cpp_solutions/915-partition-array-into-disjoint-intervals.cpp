class Solution {
public:
    int partitionDisjoint(vector<int>& A) {
        int n = A.size(), maxLeft = A[0], maxPartition = A[0], partitionIndex = 0;
        for (int i = 1; i < n; ++i) {
            if (A[i] < maxLeft) {
                partitionIndex = i;
                maxLeft = max(maxLeft, maxPartition);
            }
            maxPartition = max(maxPartition, A[i]);
        }
        return partitionIndex + 1;
    }
};