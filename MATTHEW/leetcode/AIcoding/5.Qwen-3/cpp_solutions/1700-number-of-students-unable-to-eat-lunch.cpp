#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int countStudents(vector<int>& students, vector<int>& sandwiches) {
        queue<int> q;
        for (int s : students) {
            q.push(s);
        }

        int i = 0;
        while (!q.empty() && i < sandwiches.size()) {
            if (q.front() == sandwiches[i]) {
                q.pop();
                i++;
            } else {
                break;
            }
        }

        return q.size();
    }
};