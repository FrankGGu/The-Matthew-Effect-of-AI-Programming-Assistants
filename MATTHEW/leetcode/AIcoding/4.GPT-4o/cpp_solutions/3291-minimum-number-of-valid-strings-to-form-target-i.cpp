#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minNumberOfStrings(const vector<string>& strings, const string& target) {
        unordered_map<char, int> targetCount;
        for (char c : target) {
            targetCount[c]++;
        }

        int minCount = 0;
        while (!targetCount.empty()) {
            unordered_map<char, int> currentCount;
            for (const string& str : strings) {
                unordered_map<char, int> tempCount;
                for (char c : str) {
                    if (targetCount.count(c)) {
                        tempCount[c]++;
                    }
                }
                for (const auto& entry : tempCount) {
                    currentCount[entry.first] = max(currentCount[entry.first], entry.second);
                }
            }
            for (auto it = targetCount.begin(); it != targetCount.end();) {
                if (currentCount[it->first] > 0) {
                    it->second -= currentCount[it->first];
                    if (it->second <= 0) {
                        it = targetCount.erase(it);
                    } else {
                        ++it;
                    }
                } else {
                    break;
                }
            }
            minCount++;
        }
        return minCount;
    }
};