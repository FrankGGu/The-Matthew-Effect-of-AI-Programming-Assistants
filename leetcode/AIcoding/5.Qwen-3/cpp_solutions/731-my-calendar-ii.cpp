#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    bool book(int start, int end) {
        for (auto& [s, e] : events) {
            if (start < e && end > s) {
                for (auto& [s2, e2] : events) {
                    if (s < e2 && s2 < e) {
                        return false;
                    }
                }
            }
        }
        events.push_back({start, end});
        return true;
    }

private:
    vector<pair<int, int>> events;
};