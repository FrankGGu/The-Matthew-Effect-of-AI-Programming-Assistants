class Solution {
public:
    vector<int> getImportance(vector<Employee*> employees, int id) {
        unordered_map<int, Employee*> empMap;
        for (auto emp : employees) {
            empMap[emp->id] = emp;
        }

        int totalImportance = 0;
        queue<int> q;
        q.push(id);

        while (!q.empty()) {
            int currId = q.front();
            q.pop();
            totalImportance += empMap[currId]->importance;
            for (int subId : empMap[currId]->subordinates) {
                q.push(subId);
            }
        }

        return {totalImportance};
    }
};