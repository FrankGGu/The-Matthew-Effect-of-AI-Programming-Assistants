class Solution {
public:
    int scheduleCourse(vector<vector<int>>& courses) {
        sort(courses.begin(), courses.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });
        priority_queue<int> pq;
        int time = 0;
        for (const auto& course : courses) {
            int duration = course[0];
            int lastDay = course[1];
            if (time + duration <= lastDay) {
                time += duration;
                pq.push(duration);
            } else if (!pq.empty() && pq.top() > duration) {
                time += duration - pq.top();
                pq.pop();
                pq.push(duration);
            }
        }
        return pq.size();
    }
};