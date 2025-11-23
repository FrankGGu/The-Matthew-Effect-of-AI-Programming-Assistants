#include <string>

using namespace std;

class Solution {
public:
    int countVowelSubstrings(string word, int k) {
        int n = word.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                string sub = word.substr(i, j - i + 1);
                if (isVowelSubstring(sub, k)) {
                    count++;
                }
            }
        }
        return count;
    }

private:
    bool isVowelSubstring(string s, int k) {
        int vowelCount[5] = {0};
        int consonantCount = 0;
        for (char c : s) {
            if (c == 'a') vowelCount[0]++;
            else if (c == 'e') vowelCount[1]++;
            else if (c == 'i') vowelCount[2]++;
            else if (c == 'o') vowelCount[3]++;
            else if (c == 'u') vowelCount[4]++;
            else consonantCount++;
        }
        if (vowelCount[0] > 0 && vowelCount[1] > 0 && vowelCount[2] > 0 && vowelCount[3] > 0 && vowelCount[4] > 0 && consonantCount == k) {
            return true;
        }
        return false;
    }
};