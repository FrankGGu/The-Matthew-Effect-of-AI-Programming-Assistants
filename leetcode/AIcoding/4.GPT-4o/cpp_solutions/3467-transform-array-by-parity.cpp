class Solution {
public:
    vector<int> transformArray(vector<int>& arr) {
        vector<int> result = arr;
        for (int i = 1; i < arr.size() - 1; i++) {
            if (arr[i] % 2 == 0) {
                if (arr[i - 1] % 2 != 0 && arr[i + 1] % 2 != 0) {
                    result[i] = arr[i] - 1;
                }
            } else {
                if (arr[i - 1] % 2 == 0 && arr[i + 1] % 2 == 0) {
                    result[i] = arr[i] + 1;
                }
            }
        }
        return result;
    }
};