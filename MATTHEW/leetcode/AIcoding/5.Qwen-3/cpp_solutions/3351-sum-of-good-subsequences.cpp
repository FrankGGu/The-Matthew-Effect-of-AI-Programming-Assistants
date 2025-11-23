#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>

using namespace std;

class Solution {
public:
    int sumOfGoodSubsequences(vector<string>& words) {
        unordered_map<string, int> count;
        int total = 0;
        for (const string& word : words) {
            vector<string> temp;
            for (int i = 0; i < word.size(); ++i) {
                string sub = word.substr(0, i + 1);
                if (count.find(sub) != count.end()) {
                    total += count[sub];
                }
                temp.push_back(sub);
            }
            for (const string& s : temp) {
                count[s]++;
            }
        }
        return total;
    }
};