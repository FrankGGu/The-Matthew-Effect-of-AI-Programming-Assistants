#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    long long beautifulSubstrings(string s, int k) {
        int n = s.length();
        long long ans = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                string sub = s.substr(i, j - i + 1);
                int vowels = 0;
                int consonants = 0;

                for (char c : sub) {
                    if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                        vowels++;
                    } else {
                        consonants++;
                    }
                }

                if (vowels == consonants && (vowels * consonants) % k == 0) {
                    ans++;
                }
            }
        }

        return ans;
    }
};