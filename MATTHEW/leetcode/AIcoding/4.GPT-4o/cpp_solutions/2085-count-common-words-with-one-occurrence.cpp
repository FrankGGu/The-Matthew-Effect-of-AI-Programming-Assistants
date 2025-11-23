#include <unordered_map>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    int countWords(vector<string>& words1, vector<string>& words2) {
        unordered_map<string, int> count1, count2;
        for (const auto& word : words1) {
            count1[word]++;
        }
        for (const auto& word : words2) {
            count2[word]++;
        }
        int result = 0;
        for (const auto& [word, count] : count1) {
            if (count == 1 && count2[word] == 1) {
                result++;
            }
        }
        return result;
    }
};