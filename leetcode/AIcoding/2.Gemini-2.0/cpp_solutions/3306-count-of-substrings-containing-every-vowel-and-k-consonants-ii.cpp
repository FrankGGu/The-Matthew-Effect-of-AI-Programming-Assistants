#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    long long countVowelStrings(string word, int k) {
        long long ans = 0;
        int n = word.length();
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                string sub = word.substr(i, j - i + 1);
                int vowelCount[5] = {0};
                int consonantCount = 0;
                for (char c : sub) {
                    if (c == 'a') vowelCount[0]++;
                    else if (c == 'e') vowelCount[1]++;
                    else if (c == 'i') vowelCount[2]++;
                    else if (c == 'o') vowelCount[3]++;
                    else if (c == 'u') vowelCount[4]++;
                    else consonantCount++;
                }
                bool hasAllVowels = true;
                for (int count : vowelCount) {
                    if (count == 0) {
                        hasAllVowels = false;
                        break;
                    }
                }
                if (hasAllVowels && consonantCount >= k) {
                    ans++;
                }
            }
        }
        return ans;
    }
};