class Solution {
public:
    int getImportance(vector<Employee*> employees, int id) {
        unordered_map<int, Employee*> empMap;
        for (Employee* emp : employees) {
            empMap[emp->id] = emp;
        }
        queue<int> q;
        q.push(id);
        int total = 0;
        while (!q.empty()) {
            int currentId = q.front();
            q.pop();
            Employee* emp = empMap[currentId];
            total += emp->importance;
            for (int subId : emp->subordinates) {
                q.push(subId);
            }
        }
        return total;
    }
};