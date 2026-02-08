#include <iostream>
#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    string smallestSubsequence(string s, int k, char letter, int minOccurrences) {
        int n = s.length();
        int count = 0;
        for (char c : s) {
            if (c == letter) count++;
        }

        int need = minOccurrences;
        int remove = n - k;

        stack<char> st;
        for (int i = 0; i < n; ++i) {
            char c = s[i];
            while (!st.empty() && st.top() > c && remove > 0) {
                if (st.top() == letter) {
                    if (count > need) {
                        count--;
                        remove--;
                        st.pop();
                    } else {
                        break;
                    }
                } else {
                    remove--;
                    st.pop();
                }
            }
            st.push(c);
        }

        while (remove > 0) {
            st.pop();
            remove--;
        }

        string result;
        while (!st.empty()) {
            result.push_back(st.top());
            st.pop();
        }
        reverse(result.begin(), result.end());
        return result;
    }
};