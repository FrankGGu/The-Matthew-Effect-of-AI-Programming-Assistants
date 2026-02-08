#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int inventoryManagement(vector<int>& stock, int cnt) {
        unordered_map<int, int> countMap;
        for (int num : stock) {
            countMap[num]++;
            if (countMap[num] == cnt) {
                return num;
            }
        }
        return -1;
    }
};