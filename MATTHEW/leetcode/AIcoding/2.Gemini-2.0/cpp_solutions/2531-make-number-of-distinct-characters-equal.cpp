#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool isItPossible(string word1, string word2) {
        unordered_map<char, int> freq1, freq2;
        for (char c : word1) freq1[c]++;
        for (char c : word2) freq2[c]++;

        for (char c1 : word1) {
            for (char c2 : word2) {
                unordered_map<char, int> tempFreq1 = freq1, tempFreq2 = freq2;

                tempFreq1[c1]--;
                if (tempFreq1[c1] == 0) tempFreq1.erase(c1);
                tempFreq1[c2]++;

                tempFreq2[c2]--;
                if (tempFreq2[c2] == 0) tempFreq2.erase(c2);
                tempFreq2[c1]++;

                int distinct1 = tempFreq1.size();
                int distinct2 = tempFreq2.size();

                if (distinct1 == distinct2) return true;
            }
        }

        return false;
    }
};