#include <iostream>
#include <vector>
#include <deque>

using namespace std;

class Solution {
public:
    int recentRequests(vector<int>& t) {
        deque<int> q;
        int count = 0;
        for (int time : t) {
            while (!q.empty() && time - q.front() > 3000) {
                q.pop_front();
            }
            q.push_back(time);
            count = q.size();
        }
        return count;
    }
};