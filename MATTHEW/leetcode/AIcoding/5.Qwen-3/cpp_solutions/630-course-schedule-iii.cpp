#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int scheduleCourse(vector<vector<int>>& courses) {
        sort(courses.begin(), courses.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        priority_queue<int> maxHeap;
        int time = 0;

        for (auto& course : courses) {
            int duration = course[0], lastDay = course[1];
            if (time + duration <= lastDay) {
                maxHeap.push(duration);
                time += duration;
            } else {
                if (!maxHeap.empty() && maxHeap.top() > duration) {
                    time -= maxHeap.top();
                    maxHeap.pop();
                    time += duration;
                    maxHeap.push(duration);
                }
            }
        }

        return maxHeap.size();
    }
};