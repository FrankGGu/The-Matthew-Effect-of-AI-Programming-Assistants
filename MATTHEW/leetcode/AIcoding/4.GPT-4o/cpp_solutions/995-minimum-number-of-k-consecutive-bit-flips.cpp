class Solution {
public:
    int minKBitFlips(vector<int>& A, int K) {
        int n = A.size(), flips = 0, res = 0;
        vector<int> flip(n + 1, 0);

        for (int i = 0; i < n; i++) {
            flips ^= flip[i];
            if (A[i] ^ flips == 0) {
                if (i + K > n) return -1;
                flips ^= 1;
                res++;
                if (i + K < n) flip[i + K] ^= 1;
            }
        }
        return res;
    }
};