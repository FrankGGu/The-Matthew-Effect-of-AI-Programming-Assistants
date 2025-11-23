#include <vector>
#include <unordered_map>
#include <queue>

class Solution {
public:
    int getImportance(std::vector<Employee*> employees, int id) {
        std::unordered_map<int, Employee*> employee_map;
        for (Employee* e : employees) {
            employee_map[e->id] = e;
        }

        int total_importance = 0;
        std::queue<int> q;
        q.push(id);

        while (!q.empty()) {
            int current_id = q.front();
            q.pop();

            Employee* current_employee = employee_map[current_id];
            total_importance += current_employee->importance;

            for (int subordinate_id : current_employee->subordinates) {
                q.push(subordinate_id);
            }
        }

        return total_importance;
    }
};