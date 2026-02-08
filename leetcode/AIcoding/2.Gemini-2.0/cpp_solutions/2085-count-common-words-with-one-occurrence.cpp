#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countWords(vector<string>& words1, vector<string>& words2) {
        unordered_map<string, int> count1, count2;
        for (const string& word : words1) {
            count1[word]++;
        }
        for (const string& word : words2) {
            count2[word]++;
        }

        int result = 0;
        for (const auto& pair : count1) {
            if (pair.second == 1 && count2.count(pair.first) && count2[pair.first] == 1) {
                result++;
            }
        }

        return result;
    }
};