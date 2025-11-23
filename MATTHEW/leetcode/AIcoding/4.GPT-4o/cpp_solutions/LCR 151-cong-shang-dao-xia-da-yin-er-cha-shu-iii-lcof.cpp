#include <vector>
#include <unordered_map>
#include <string>
#include <algorithm>
using namespace std;

class Solution {
public:
    int countWays(vector<string>& logs) {
        unordered_map<string, int> count;
        for (const string& log : logs) {
            count[log]++;
        }

        int total = 0;
        for (const auto& entry : count) {
            total += entry.second;
        }

        return total;
    }
};