#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int countStudents(vector<int>& students, vector<int>& sandwiches) {
        queue<int> studentQueue;
        for (int student : students) {
            studentQueue.push(student);
        }

        int sandwichIndex = 0;
        int stuckCount = 0;

        while (!studentQueue.empty() && stuckCount < studentQueue.size()) {
            if (studentQueue.front() == sandwiches[sandwichIndex]) {
                studentQueue.pop();
                sandwichIndex++;
                stuckCount = 0;
            } else {
                studentQueue.push(studentQueue.front());
                studentQueue.pop();
                stuckCount++;
            }
        }

        return studentQueue.size();
    }
};