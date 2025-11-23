#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
private:
    unordered_map<int, int> map;
    int size;

public:
    Solution(int n, vector<int>& blacklist) {
        size = n - blacklist.size();
        sort(blacklist.begin(), blacklist.end());
        int last = n - 1;
        for (int i = blacklist.size() - 1; i >= 0; --i) {
            if (blacklist[i] < size) {
                map[blacklist[i]] = last;
                --last;
            }
        }
    }

    int pick() {
        int randNum = rand() % size;
        return map.count(randNum) ? map[randNum] : randNum;
    }
};