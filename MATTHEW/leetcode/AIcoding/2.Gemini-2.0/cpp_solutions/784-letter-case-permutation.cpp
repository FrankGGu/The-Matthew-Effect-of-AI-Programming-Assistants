#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    vector<string> letterCasePermutation(string s) {
        vector<string> result;
        letterCasePermutationHelper(s, 0, result);
        return result;
    }

private:
    void letterCasePermutationHelper(string s, int index, vector<string>& result) {
        if (index == s.length()) {
            result.push_back(s);
            return;
        }

        if (isalpha(s[index])) {
            s[index] = isupper(s[index]) ? tolower(s[index]) : toupper(s[index]);
            letterCasePermutationHelper(s, index + 1, result);
            s[index] = isupper(s[index]) ? tolower(s[index]) : toupper(s[index]);
            letterCasePermutationHelper(s, index + 1, result);
        } else {
            letterCasePermutationHelper(s, index + 1, result);
        }
    }
};