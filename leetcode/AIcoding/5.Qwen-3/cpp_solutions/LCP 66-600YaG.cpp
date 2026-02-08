#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minStalls(vector<int>& stalls, int k) {
        unordered_map<int, int> count;
        for (int stall : stalls) {
            count[stall]++;
        }
        int result = 0;
        for (auto& [key, value] : count) {
            if (value >= k) {
                result += value / k;
            }
        }
        return result;
    }
};