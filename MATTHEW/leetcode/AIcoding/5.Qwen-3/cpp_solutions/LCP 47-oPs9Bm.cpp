#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int securityCheck(vector<int>& people, int k) {
        queue<int> q;
        for (int i = 0; i < people.size(); ++i) {
            q.push(i);
        }
        int count = 0;
        while (!q.empty()) {
            int current = q.front();
            q.pop();
            if (people[current] % k == 0) {
                ++count;
            } else {
                q.push(current);
            }
        }
        return count;
    }
};