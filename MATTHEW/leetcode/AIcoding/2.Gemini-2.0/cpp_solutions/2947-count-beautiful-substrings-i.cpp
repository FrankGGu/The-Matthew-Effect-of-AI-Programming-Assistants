#include <string>

using namespace std;

class Solution {
public:
    int beautifulSubstrings(string s, int k) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int vowels = 0;
                int consonants = 0;
                for (int l = i; l <= j; ++l) {
                    if (s[l] == 'a' || s[l] == 'e' || s[l] == 'i' || s[l] == 'o' || s[l] == 'u') {
                        vowels++;
                    } else {
                        consonants++;
                    }
                }
                if (vowels == consonants && (vowels * consonants) % k == 0) {
                    count++;
                }
            }
        }
        return count;
    }
};