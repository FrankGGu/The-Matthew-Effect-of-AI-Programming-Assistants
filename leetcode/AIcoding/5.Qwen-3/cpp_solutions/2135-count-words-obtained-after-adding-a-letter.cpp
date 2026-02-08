#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countWords(vector<string>& nums, vector<string>& target) {
        unordered_map<string, int> count;
        for (const string& word : nums) {
            ++count[word];
        }
        int result = 0;
        for (const string& word : target) {
            if (count.find(word) != count.end() && count[word] > 0) {
                --count[word];
                ++result;
            }
        }
        return result;
    }
};