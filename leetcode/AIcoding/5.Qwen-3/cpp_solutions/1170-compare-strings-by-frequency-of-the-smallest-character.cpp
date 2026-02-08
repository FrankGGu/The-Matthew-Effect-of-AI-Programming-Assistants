#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int frequency(const string& s) {
        char minChar = *min_element(s.begin(), s.end());
        int count = 0;
        for (char c : s) {
            if (c == minChar) {
                ++count;
            }
        }
        return count;
    }

    vector<int> numSmallerByFrequency(vector<string>& queries, vector<string>& words) {
        vector<int> wordFreq;
        for (const string& word : words) {
            wordFreq.push_back(frequency(word));
        }
        sort(wordFreq.begin(), wordFreq.end());
        vector<int> result;
        for (const string& query : queries) {
            int qFreq = frequency(query);
            int count = 0;
            for (int freq : wordFreq) {
                if (qFreq < freq) {
                    ++count;
                }
            }
            result.push_back(count);
        }
        return result;
    }
};