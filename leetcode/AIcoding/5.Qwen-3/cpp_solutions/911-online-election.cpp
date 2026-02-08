#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> q;
    map<int, int> count;
    vector<int> leaders;

    Solution(vector<int>& people, vector<int>& time) {
        int n = people.size();
        for (int i = 0; i < n; ++i) {
            count[people[i]]++;
            leaders.push_back(people[i]);
        }
        sort(leaders.begin(), leaders.end());
        for (int i = 0; i < n; ++i) {
            q.push_back(time[i]);
        }
    }

    int get(int t) {
        int left = 0, right = q.size() - 1;
        while (left < right) {
            int mid = left + (right - left + 1) / 2;
            if (q[mid] <= t)
                left = mid;
            else
                right = mid - 1;
        }
        int idx = left;
        int maxVotes = 0;
        int leader = -1;
        for (int i = 0; i <= idx; ++i) {
            if (count[people[i]] > maxVotes) {
                maxVotes = count[people[i]];
                leader = people[i];
            }
        }
        return leader;
    }
};