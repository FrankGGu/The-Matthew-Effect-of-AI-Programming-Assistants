#include <iostream>
#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    bool isPalindrome(string s) {
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (s[left] != s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    bool dfs(string& s, int start, int end, int depth) {
        if (start > end) {
            return false;
        }
        if (depth == 0) {
            return isPalindrome(s.substr(start, end - start + 1));
        }
        for (int i = start; i <= end; ++i) {
            if (dfs(s, start, i - 1, depth - 1) && dfs(s, i + 1, end, depth - 1)) {
                return true;
            }
        }
        return false;
    }

    bool checkIfDFSStringsArePalindromes(string s) {
        int n = s.length();
        for (int depth = 0; depth <= n; ++depth) {
            if (dfs(s, 0, n - 1, depth)) {
                return true;
            }
        }
        return false;
    }
};