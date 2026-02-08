#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int scheduleCourse(vector<vector<int>>& courses) {
        sort(courses.begin(), courses.end(), [](const auto& a, const auto& b) {
            return a[1] < b[1];
        });

        priority_queue<int> pq;
        int time = 0;

        for (auto& course : courses) {
            int duration = course[0];
            int lastDay = course[1];

            if (time + duration <= lastDay) {
                pq.push(duration);
                time += duration;
            } else if (!pq.empty() && duration < pq.top()) {
                time -= pq.top();
                pq.pop();
                pq.push(duration);
                time += duration;
            }
        }

        return pq.size();
    }
};