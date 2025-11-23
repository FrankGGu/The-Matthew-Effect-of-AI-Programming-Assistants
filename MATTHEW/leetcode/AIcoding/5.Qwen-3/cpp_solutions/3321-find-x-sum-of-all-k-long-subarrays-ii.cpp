#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    long long kSum(int n, vector<int>& ranges, int k) {
        vector<vector<int>> intervals;
        for (int i = 0; i < n; ++i) {
            intervals.push_back({ranges[2 * i], ranges[2 * i + 1]});
        }

        sort(intervals.begin(), intervals.end());

        vector<pair<int, int>> merged;
        for (const auto& interval : intervals) {
            if (merged.empty() || merged.back().second < interval[0]) {
                merged.push_back(interval);
            } else {
                merged.back().second = max(merged.back().second, interval[1]);
            }
        }

        vector<long long> prefixSums;
        for (int i = 0; i < merged.size(); ++i) {
            int start = merged[i][0];
            int end = merged[i][1];
            long long sum = (long long)(end - start + 1) * (start + end) / 2;
            prefixSums.push_back(sum);
        }

        priority_queue<long long, vector<long long>, greater<long long>> minHeap;
        for (int i = 0; i < prefixSums.size(); ++i) {
            minHeap.push(prefixSums[i]);
        }

        for (int i = 1; i < prefixSums.size(); ++i) {
            for (int j = 0; j < i; ++j) {
                long long sum = prefixSums[i] + prefixSums[j];
                if (minHeap.size() < k) {
                    minHeap.push(sum);
                } else if (sum < minHeap.top()) {
                    minHeap.pop();
                    minHeap.push(sum);
                }
            }
        }

        long long result = 0;
        for (int i = 0; i < k; ++i) {
            result += minHeap.top();
            minHeap.pop();
        }

        return result;
    }
};