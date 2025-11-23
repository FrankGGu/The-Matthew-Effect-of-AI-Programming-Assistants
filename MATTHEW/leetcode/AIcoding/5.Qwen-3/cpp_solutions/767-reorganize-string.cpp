#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string reorganizeString(vector<char>& nums) {
        unordered_map<char, int> freq;
        for (char c : nums) {
            freq[c]++;
        }

        priority_queue<pair<int, char>> maxHeap;
        for (auto& [c, count] : freq) {
            maxHeap.push({count, c});
        }

        string result;
        pair<int, char> prev = {0, '0'};
        while (!maxHeap.empty()) {
            auto [count, c] = maxHeap.top();
            maxHeap.pop();
            result += c;
            if (prev.first > 0) {
                maxHeap.push(prev);
            }
            prev = {count - 1, c};
        }

        return result.length() == nums.size() ? result : "";
    }
};