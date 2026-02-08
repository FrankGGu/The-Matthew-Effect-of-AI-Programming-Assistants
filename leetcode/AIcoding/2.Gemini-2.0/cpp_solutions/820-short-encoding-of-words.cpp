#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumLengthEncoding(vector<string>& words) {
        sort(words.begin(), words.end(), [](const string& a, const string& b) {
            return a.length() > b.length();
        });

        string s = "";
        for (const string& word : words) {
            if (s.find(word + "#") == string::npos) {
                s += word + "#";
            }
        }
        return s.length();
    }
};