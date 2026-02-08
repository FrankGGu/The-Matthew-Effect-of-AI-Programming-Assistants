class Solution {
public:
    int maxLength(vector<string>& arr) {
        unordered_set<char> current;
        return dfs(arr, 0, current);
    }

    int dfs(vector<string>& arr, int index, unordered_set<char>& current) {
        if (index == arr.size()) {
            return current.size();
        }

        int maxLen = dfs(arr, index + 1, current);

        unordered_set<char> temp(current);
        bool canAdd = true;
        for (char c : arr[index]) {
            if (current.count(c)) {
                canAdd = false;
                break;
            }
            temp.insert(c);
        }

        if (canAdd) {
            maxLen = max(maxLen, dfs(arr, index + 1, temp));
        }

        return maxLen;
    }
};