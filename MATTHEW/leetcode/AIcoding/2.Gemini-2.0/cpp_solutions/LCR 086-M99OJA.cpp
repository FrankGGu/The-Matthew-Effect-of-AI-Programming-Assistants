#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<vector<string>> partition(string s) {
        vector<vector<string>> result;
        vector<string> currentList;
        dfs(s, 0, currentList, result);
        return result;
    }

private:
    void dfs(string s, int start, vector<string>& currentList, vector<vector<string>>& result) {
        if (start >= s.length()) {
            result.push_back(currentList);
            return;
        }

        for (int i = start; i < s.length(); i++) {
            if (isPalindrome(s, start, i)) {
                currentList.push_back(s.substr(start, i - start + 1));
                dfs(s, i + 1, currentList, result);
                currentList.pop_back();
            }
        }
    }

    bool isPalindrome(string s, int low, int high) {
        while (low < high) {
            if (s[low++] != s[high--]) return false;
        }
        return true;
    }
};