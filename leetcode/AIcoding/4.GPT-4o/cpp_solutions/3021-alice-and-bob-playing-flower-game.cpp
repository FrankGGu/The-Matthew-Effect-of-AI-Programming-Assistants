class Solution {
public:
    string flowerGame(vector<int>& A) {
        int n = A.size();
        int total = accumulate(A.begin(), A.end(), 0);
        int max_A = *max_element(A.begin(), A.end());

        for (int i = 0; i < n; ++i) {
            if (A[i] == max_A) {
                if ((total - A[i]) % 2 == 0) {
                    return "Alice";
                } else {
                    return "Bob";
                }
            }
        }
        return "Bob";
    }
};