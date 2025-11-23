class Solution {
public:
    int captureForts(vector<int>& forts) {
        int maxForts = 0;
        int n = forts.size();
        for (int i = 0; i < n; ++i) {
            if (forts[i] == 1) {
                int left = i - 1;
                while (left >= 0 && forts[left] == 0) {
                    left--;
                }
                if (left >= 0 && forts[left] == -1) {
                    maxForts = max(maxForts, i - left - 1);
                }
                int right = i + 1;
                while (right < n && forts[right] == 0) {
                    right++;
                }
                if (right < n && forts[right] == -1) {
                    maxForts = max(maxForts, right - i - 1);
                }
            }
        }
        return maxForts;
    }
};