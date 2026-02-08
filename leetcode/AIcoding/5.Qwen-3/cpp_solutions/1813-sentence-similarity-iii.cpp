#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    bool areSentencesSimilar(string sentence1, string sentence2) {
        vector<string> words1, words2;
        stringstream ss1(sentence1), ss2(sentence2);
        string word;

        while (ss1 >> word) {
            words1.push_back(word);
        }

        while (ss2 >> word) {
            words2.push_back(word);
        }

        int i = 0, j = 0;
        int n = words1.size(), m = words2.size();

        if (n == 0 || m == 0) return true;

        while (i < n && j < m && words1[i] == words2[j]) {
            i++;
            j++;
        }

        int k = n - 1, l = m - 1;
        while (k >= 0 && l >= 0 && words1[k] == words2[l]) {
            k--;
            l--;
        }

        return i > k && j > l;
    }
};