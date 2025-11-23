#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findValidPosition(vector<int>& positions, int n) {
        unordered_map<int, int> count;
        for (int pos : positions) {
            count[pos]++;
        }
        for (int i = 1; i <= n; ++i) {
            if (count.find(i) == count.end()) {
                return i;
            }
        }
        return n + 1;
    }
};