#include <vector>
#include <unordered_map>

using namespace std;

class Employee {
public:
    int id;
    int importance;
    vector<int> subordinates;
};

class Solution {
public:
    int getImportance(vector<Employee*> employees, int id) {
        unordered_map<int, Employee*> empMap;
        for (Employee* emp : employees) {
            empMap[emp->id] = emp;
        }

        int totalImportance = 0;
        vector<int> q;
        q.push_back(id);

        while (!q.empty()) {
            int currId = q.front();
            q.erase(q.begin());

            Employee* currEmp = empMap[currId];
            totalImportance += currEmp->importance;

            for (int subId : currEmp->subordinates) {
                q.push_back(subId);
            }
        }

        return totalImportance;
    }
};