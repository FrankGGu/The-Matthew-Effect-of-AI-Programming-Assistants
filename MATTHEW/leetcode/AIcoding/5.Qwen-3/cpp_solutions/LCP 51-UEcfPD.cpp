#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int numRabbits(int n, vector<int>& answers) {
        unordered_map<int, int> count;
        for (int ans : answers) {
            count[ans]++;
        }

        int result = 0;
        for (auto& [k, v] : count) {
            if (k == 0) {
                result += v;
            } else {
                int groupSize = k + 1;
                int groups = (v + groupSize - 1) / groupSize;
                result += groups * groupSize;
            }
        }
        return result;
    }
};