#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int keyboard(int n, vector<int>& cost) {
        unordered_map<char, int> keyMap;
        for (int i = 0; i < n; ++i) {
            char c = 'a' + i;
            keyMap[c] = cost[i];
        }

        string s;
        cin >> s;

        int totalCost = 0;
        for (char c : s) {
            totalCost += keyMap[c];
        }

        return totalCost;
    }
};