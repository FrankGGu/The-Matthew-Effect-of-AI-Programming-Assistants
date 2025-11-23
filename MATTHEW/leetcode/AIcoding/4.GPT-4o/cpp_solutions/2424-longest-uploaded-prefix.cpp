class Solution {
public:
    int longestUploadedPrefix(vector<int>& A) {
        int maxLength = 0;
        int totalUploads = 0;

        for (int i = 0; i < A.size(); ++i) {
            totalUploads += A[i];
            if (totalUploads >= i + 1) {
                maxLength = i + 1;
            }
        }

        return maxLength;
    }
};