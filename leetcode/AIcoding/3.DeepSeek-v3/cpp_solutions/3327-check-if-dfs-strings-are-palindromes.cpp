#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool isPalindrome(const string& s) {
        int left = 0, right = s.size() - 1;
        while (left < right) {
            if (s[left] != s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    bool canFormPalindrome(vector<string>& words) {
        unordered_map<char, int> freq;
        for (const string& word : words) {
            for (char c : word) {
                freq[c]++;
            }
        }

        int oddCount = 0;
        for (const auto& pair : freq) {
            if (pair.second % 2 != 0) {
                oddCount++;
            }
            if (oddCount > 1) {
                return false;
            }
        }

        return true;
    }

    bool canFormArray(vector<string>& words) {
        return canFormPalindrome(words);
    }
};