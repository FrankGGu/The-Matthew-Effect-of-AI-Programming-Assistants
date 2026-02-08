#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<bool> canTake(vector<int>& n, vector<vector<int>>& relations) {
        int numCourses = n.size();
        vector<vector<int>> adj(numCourses);
        vector<int> inDegree(numCourses, 0);

        for (const auto& rel : relations) {
            int course = rel[0];
            int prerequisite = rel[1];
            adj[prerequisite].push_back(course);
            inDegree[course]++;
        }

        queue<int> q;
        for (int i = 0; i < numCourses; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        vector<bool> result(numCourses, false);
        while (!q.empty()) {
            int current = q.front();
            q.pop();
            result[current] = true;
            for (int neighbor : adj[current]) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        return result;
    }
};