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

        for (int end = start; end < s.length(); end++) {
            if (isPalindrome(s, start, end)) {
                currentList.push_back(s.substr(start, end - start + 1));
                dfs(s, end + 1, currentList, result);
                currentList.pop_back();
            }
        }
    }

    bool isPalindrome(string s, int start, int end) {
        while (start <= end) {
            if (s[start++] != s[end--])
                return false;
        }
        return true;
    }
};