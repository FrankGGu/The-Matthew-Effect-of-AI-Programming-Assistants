class Solution {
public:
    int findSpecialInteger(std::vector<int>& arr) {
        int n = arr.size();
        int threshold_count = n / 4; 

        for (int i = 0; i < n - threshold_count; ++i) {
            if (arr[i] == arr[i + threshold_count]) {
                return arr[i];
            }
        }

        return -1; 
    }
};