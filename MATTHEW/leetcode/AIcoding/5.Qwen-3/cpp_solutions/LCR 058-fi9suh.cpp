#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<pair<int, int>> schedule;

    bool book(int start, int end) {
        for (const auto& s : schedule) {
            if (max(s.first, start) < min(s.second, end)) {
                return false;
            }
        }
        schedule.emplace_back(start, end);
        return true;
    }
};