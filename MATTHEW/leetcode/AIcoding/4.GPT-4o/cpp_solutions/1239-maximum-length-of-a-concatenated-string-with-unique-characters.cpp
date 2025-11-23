class Solution {
public:
    int maxLength(vector<string>& arr) {
        return backtrack(arr, 0, "");
    }

private:
    int backtrack(vector<string>& arr, int index, string current) {
        if (!isUnique(current)) return 0;
        int maxLength = current.size();
        for (int i = index; i < arr.size(); ++i) {
            maxLength = max(maxLength, backtrack(arr, i + 1, current + arr[i]));
        }
        return maxLength;
    }

    bool isUnique(const string& s) {
        vector<bool> seen(26, false);
        for (char c : s) {
            if (seen[c - 'a']) return false;
            seen[c - 'a'] = true;
        }
        return true;
    }
};