class Solution {
public:
    vector<vector<int>> findPossibleArrays(int n) {
        vector<vector<int>> result;
        vector<int> current;
        backtrack(n, current, result);
        return result;
    }

    void backtrack(int n, vector<int>& current, vector<vector<int>>& result) {
        if (current.size() == n) {
            result.push_back(current);
            return;
        }
        for (int i = 0; i <= 1; ++i) {
            if (isValid(current, i)) {
                current.push_back(i);
                backtrack(n, current, result);
                current.pop_back();
            }
        }
    }

    bool isValid(const vector<int>& arr, int num) {
        int size = arr.size();
        if (size < 2) return true;
        if (arr[size - 1] == 1 && num == 1) return false;
        if (arr[size - 2] == 1 && arr[size - 1] == 1 && num == 1) return false;
        return true;
    }
};