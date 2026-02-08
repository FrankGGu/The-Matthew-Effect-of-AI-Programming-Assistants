class Solution {
public:
    int longestMountain(vector<int>& arr) {
        int n = arr.size();
        if (n < 3) return 0;
        int max_len = 0;
        for (int i = 1; i < n - 1; ) {
            if (arr[i] > arr[i-1] && arr[i] > arr[i+1]) {
                int left = i - 1;
                while (left > 0 && arr[left] > arr[left-1]) {
                    left--;
                }
                int right = i + 1;
                while (right < n - 1 && arr[right] > arr[right+1]) {
                    right++;
                }
                max_len = max(max_len, right - left + 1);
                i = right + 1;
            } else {
                i++;
            }
        }
        return max_len;
    }
};