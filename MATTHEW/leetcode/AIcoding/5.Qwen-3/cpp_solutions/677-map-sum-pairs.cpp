#include <iostream>
#include <vector>
#include <map>
#include <string>

using namespace std;

class Solution {
public:
    void insert(string key, int val) {
        int delta = val - map[key];
        map[key] = val;
        for (int i = 1; i <= key.size(); ++i) {
            string prefix = key.substr(0, i);
            prefixSum[prefix] += delta;
        }
    }

    int sum(string prefix) {
        return prefixSum[prefix];
    }

private:
    map<string, int> map;
    map<string, int> prefixSum;
};