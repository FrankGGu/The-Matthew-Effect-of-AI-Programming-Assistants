#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<bool> canPalindrome;
    vector<bool> visited;

    bool isPalindrome(const string& s, int left, int right) {
        while (left < right) {
            if (s[left] != s[right]) return false;
            left++;
            right--;
        }
        return true;
    }

    bool dfs(const string& s, int index) {
        if (index == s.size()) return true;
        if (visited[index]) return canPalindrome[index];
        for (int i = index; i < s.size(); ++i) {
            if (isPalindrome(s, index, i)) {
                visited[index] = true;
                if (dfs(s, i + 1)) {
                    canPalindrome[index] = true;
                    return true;
                }
            }
        }
        canPalindrome[index] = false;
        return false;
    }

    vector<bool> checkPartitioning(string s) {
        int n = s.size();
        canPalindrome.resize(n, false);
        visited.resize(n, false);
        dfs(s, 0);
        return canPalindrome;
    }
};