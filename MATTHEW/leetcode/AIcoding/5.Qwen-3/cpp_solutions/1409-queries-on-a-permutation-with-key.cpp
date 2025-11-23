#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> findPermutationWithKey(string s, int k) {
        vector<int> result;
        map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }
        for (int i = 0; i < k; ++i) {
            char key = 'a' + i;
            if (freq.find(key) != freq.end()) {
                result.push_back(freq[key]);
            } else {
                result.push_back(0);
            }
        }
        return result;
    }
};