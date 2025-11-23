#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    long long clash(vector<int>& colors) {
        unordered_map<int, long long> countMap;
        long long n = colors.size();
        for (int color : colors) {
            countMap[color]++;
        }

        long long totalPairs = n * (n - 1) / 2;
        long long samePairs = 0;
        for (auto& kv : countMap) {
            long long cnt = kv.second;
            samePairs += cnt * (cnt - 1) / 2;
        }

        return totalPairs - samePairs;
    }
};