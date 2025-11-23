class Solution {
public:
    vector<string> generateBinaryStrings(int n) {
        vector<string> result;
        string current;
        backtrack(n, current, result, '\0');
        return result;
    }

private:
    void backtrack(int n, string& current, vector<string>& result, char last) {
        if (n == 0) {
            result.push_back(current);
            return;
        }

        current.push_back('1');
        backtrack(n - 1, current, result, '1');
        current.pop_back();

        if (last != '0') {
            current.push_back('0');
            backtrack(n - 1, current, result, '0');
            current.pop_back();
        }
    }
};