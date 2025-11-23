#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> sequenceReconstruction(vector<int>& nums, vector<vector<int>>& sequences) {
        unordered_map<int, int> inDegree;
        unordered_map<int, vector<int>> graph;

        for (const auto& seq : sequences) {
            for (int i = 0; i < seq.size(); ++i) {
                if (i > 0) {
                    graph[seq[i - 1]].push_back(seq[i]);
                    inDegree[seq[i]]++;
                }
                if (inDegree.find(seq[i]) == inDegree.end()) {
                    inDegree[seq[i]] = 0;
                }
            }
        }

        vector<int> zeroInDegree;
        for (const auto& num : nums) {
            if (inDegree[num] == 0) {
                zeroInDegree.push_back(num);
            }
        }

        if (zeroInDegree.size() != 1) return {};

        vector<int> result;
        while (!zeroInDegree.empty()) {
            if (zeroInDegree.size() > 1) return {};
            int current = zeroInDegree.back();
            zeroInDegree.pop_back();
            result.push_back(current);
            for (int neighbor : graph[current]) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    zeroInDegree.push_back(neighbor);
                }
            }
        }

        return result.size() == nums.size() && result == nums ? result : vector<int>();
    }
};