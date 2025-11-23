class Solution {
public:
    int countKdivSubarr(vector<int>& A, int K) {
        unordered_map<int, int> prefixCount;
        prefixCount[0] = 1;
        int count = 0, prefixSum = 0;

        for (int num : A) {
            prefixSum += num;
            int mod = ((prefixSum % K) + K) % K;
            count += prefixCount[mod];
            prefixCount[mod]++;
        }
        return count;
    }
};