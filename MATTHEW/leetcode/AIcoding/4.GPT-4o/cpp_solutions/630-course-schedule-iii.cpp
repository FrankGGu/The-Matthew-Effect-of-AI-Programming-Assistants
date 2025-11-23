class Solution {
public:
    int scheduleCourse(vector<vector<int>>& courses) {
        sort(courses.begin(), courses.end(), [](vector<int>& a, vector<int>& b) {
            return a[1] < b[1];
        });
        priority_queue<int> maxHeap;
        int currentTime = 0;

        for (const auto& course : courses) {
            currentTime += course[0];
            maxHeap.push(course[0]);
            if (currentTime > course[1]) {
                currentTime -= maxHeap.top();
                maxHeap.pop();
            }
        }
        return maxHeap.size();
    }
};