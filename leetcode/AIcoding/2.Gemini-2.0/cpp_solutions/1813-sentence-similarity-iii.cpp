#include <string>
#include <vector>
#include <sstream>

using namespace std;

class Solution {
public:
    bool areSentencesSimilar(string sentence1, string sentence2) {
        vector<string> s1, s2;
        stringstream ss1(sentence1), ss2(sentence2);
        string word;
        while (ss1 >> word) s1.push_back(word);
        while (ss2 >> word) s2.push_back(word);

        int i = 0, j = 0;
        while (i < s1.size() && j < s2.size() && s1[i] == s2[j]) {
            i++;
            j++;
        }

        int m = s1.size() - 1, n = s2.size() - 1;
        while (m >= 0 && n >= 0 && s1[m] == s2[n]) {
            m--;
            n--;
        }

        return (i > m || j > n);
    }
};