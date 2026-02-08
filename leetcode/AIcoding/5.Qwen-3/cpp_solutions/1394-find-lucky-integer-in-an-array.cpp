#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findLucky(vector<int>& arr) {
        unordered_map<int, int> count;
        for (int num : arr) {
            count[num]++;
        }
        for (auto& pair : count) {
            if (pair.first == pair.second) {
                return pair.first;
            }
        }
        return -1;
    }
};