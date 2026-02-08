#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string smallestSubsequence(string s, int k, char letter, int repetition) {
        int n = s.size();
        int letterCount = 0;
        for (char c : s) {
            if (c == letter) {
                letterCount++;
            }
        }

        vector<char> stack;
        for (int i = 0; i < n; i++) {
            while (!stack.empty() && stack.back() > s[i] &&
                   (n - i + stack.size() > k) &&
                   (stack.back() != letter || letterCount > repetition)) {
                if (stack.back() == letter) {
                    repetition++;
                }
                stack.pop_back();
            }

            if (stack.size() < k) {
                if (s[i] == letter) {
                    stack.push_back(s[i]);
                    repetition--;
                } else if (k - (int)stack.size() > repetition) {
                    stack.push_back(s[i]);
                }
            }

            if (s[i] == letter) {
                letterCount--;
            }
        }

        return string(stack.begin(), stack.end());
    }
};