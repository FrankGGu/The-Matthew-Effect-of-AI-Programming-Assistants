#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int getImportance(vector<Employee*> employees, int id) {
        unordered_map<int, Employee*> empMap;
        for (auto emp : employees) {
            empMap[emp->id] = emp;
        }

        int totalImportance = 0;
        unordered_set<int> visited;
        vector<int> queue;
        queue.push_back(id);
        visited.insert(id);

        while (!queue.empty()) {
            int currentId = queue.back();
            queue.pop_back();
            Employee* current = empMap[currentId];
            totalImportance += current->importance;

            for (int subId : current->subordinates) {
                if (visited.find(subId) == visited.end()) {
                    visited.insert(subId);
                    queue.push_back(subId);
                }
            }
        }

        return totalImportance;
    }
};