#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string firstPalindrome(vector<string>& words) {
        for (string& word : words) {
            if (isPalindrome(word)) {
                return word;
            }
        }
        return "";
    }

private:
    bool isPalindrome(const string& s) {
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
};