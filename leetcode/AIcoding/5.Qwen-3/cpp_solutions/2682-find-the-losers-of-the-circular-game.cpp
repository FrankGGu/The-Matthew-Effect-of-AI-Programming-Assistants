#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> findLosers(int n, vector<int>& rounds) {
        vector<int> result;
        vector<int> count(n, 0);
        for (int round : rounds) {
            count[round - 1]++;
        }
        for (int i = 0; i < n; ++i) {
            if (count[i] == 0) {
                result.push_back(i + 1);
            }
        }
        return result;
    }
};