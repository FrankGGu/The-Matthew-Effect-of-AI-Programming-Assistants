#include <vector>
#include <algorithm>
#include <queue>

class Solution {
public:
    int scheduleCourse(std::vector<std::vector<int>>& courses) {
        std::sort(courses.begin(), courses.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[1] < b[1];
        });

        std::priority_queue<int> pq;
        int currentTime = 0;

        for (const auto& course : courses) {
            int duration = course[0];
            int lastDay = course[1];

            if (currentTime + duration <= lastDay) {
                currentTime += duration;
                pq.push(duration);
            } else if (!pq.empty() && pq.top() > duration) {
                currentTime -= pq.top();
                pq.pop();
                currentTime += duration;
                pq.push(duration);
            }
        }

        return pq.size();
    }
};