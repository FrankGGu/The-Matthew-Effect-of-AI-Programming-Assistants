#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    bool arePalindromes(string s1, string s2) {
        return isPalindrome(s1) && isPalindrome(s2);
    }

    bool isPalindrome(string s) {
        stack<char> st;
        for (char c : s) {
            if (c != '#') st.push(c);
        }

        for (char c : s) {
            if (c != '#') {
                if (st.empty() || st.top() != c) return false;
                st.pop();
            }
        }
        return st.empty();
    }
};