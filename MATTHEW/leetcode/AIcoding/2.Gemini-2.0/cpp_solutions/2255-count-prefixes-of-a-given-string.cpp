#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int countPrefixes(vector<string>& words, string s) {
        int count = 0;
        for (const string& word : words) {
            if (s.rfind(word, 0) == 0) {
                count++;
            }
        }
        return count;
    }
};