#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maximumNumberOfStringPairs(const vector<string>& words) {
        unordered_map<string, int> count;
        int result = 0;
        for (const string& word : words) {
            string reversed = word;
            reverse(reversed.begin(), reversed.end());
            if (count[reversed] > 0) {
                result++;
                count[reversed]--;
            } else {
                count[word]++;
            }
        }
        return result;
    }
};