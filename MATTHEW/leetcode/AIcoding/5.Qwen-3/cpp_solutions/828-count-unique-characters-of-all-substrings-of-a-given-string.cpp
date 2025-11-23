#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int uniqueLetterCount(const string& s) {
        vector<int> prev(26, -1);
        vector<int> last(26, -1);
        int res = 0;
        for (int i = 0; i < s.length(); ++i) {
            int c = s[i] - 'a';
            int pre = prev[c];
            int las = last[c];
            res += (i - las) * (las - pre);
            prev[c] = las;
            last[c] = i;
        }
        return res;
    }

    int uniqueLetterCountWithAllSubstrings(const string& s) {
        vector<int> prev(26, -1);
        vector<int> last(26, -1);
        int res = 0;
        for (int i = 0; i < s.length(); ++i) {
            int c = s[i] - 'a';
            int pre = prev[c];
            int las = last[c];
            res += (i - las) * (las - pre);
            prev[c] = las;
            last[c] = i;
        }
        return res;
    }

    int uniqueLetterCountOfAllSubstrings(const string& s) {
        return uniqueLetterCountWithAllSubstrings(s);
    }

    int countLetters(string s) {
        return uniqueLetterCountOfAllSubstrings(s);
    }
};