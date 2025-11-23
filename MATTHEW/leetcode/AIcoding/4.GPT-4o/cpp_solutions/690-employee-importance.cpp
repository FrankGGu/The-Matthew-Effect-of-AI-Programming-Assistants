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
        for (auto emp : employees) {
            empMap[emp->id] = emp;
        }

        return dfs(empMap, id);
    }

    int dfs(unordered_map<int, Employee*>& empMap, int id) {
        Employee* emp = empMap[id];
        int totalImportance = emp->importance;

        for (int subId : emp->subordinates) {
            totalImportance += dfs(empMap, subId);
        }

        return totalImportance;
    }
};