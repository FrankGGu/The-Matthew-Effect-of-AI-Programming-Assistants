class Solution {
public:
    int countSubarrays(vector<int>& A, vector<int>& B) {
        int n = A.size(), m = B.size();
        if (m > n) return 0;

        unordered_map<int, int> freqA, freqB;
        for (int num : B) {
            freqB[num]++;
        }

        int count = 0;
        for (int i = 0; i < m; ++i) {
            freqA[A[i]]++;
        }

        if (freqA == freqB) count++;

        for (int i = m; i < n; ++i) {
            freqA[A[i]]++;
            freqA[A[i - m]]--;
            if (freqA[A[i - m]] == 0) {
                freqA.erase(A[i - m]);
            }
            if (freqA == freqB) count++;
        }

        return count;
    }
};