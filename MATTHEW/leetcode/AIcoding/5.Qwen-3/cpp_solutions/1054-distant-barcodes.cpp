#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> rearrangeBarcodes(vector<int>& barcodes) {
        if (barcodes.empty()) return {};

        unordered_map<int, int> freq;
        for (int code : barcodes) {
            freq[code]++;
        }

        priority_queue<pair<int, int>> maxHeap;
        for (auto& [code, count] : freq) {
            maxHeap.push({count, code});
        }

        vector<int> result;
        while (!maxHeap.empty()) {
            auto [count, code] = maxHeap.top();
            maxHeap.pop();
            result.push_back(code);
            count--;

            if (!maxHeap.empty()) {
                auto [nextCount, nextCode] = maxHeap.top();
                maxHeap.pop();
                result.push_back(nextCode);
                nextCount--;

                if (nextCount > 0) {
                    maxHeap.push({nextCount, nextCode});
                }
            }

            if (count > 0) {
                maxHeap.push({count, code});
            }
        }

        return result;
    }
};