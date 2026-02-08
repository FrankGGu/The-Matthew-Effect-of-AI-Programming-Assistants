#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class TaskManager {
public:
    TaskManager(int n) : n(n), cooldown(vector<int>(n, 0)), time(0) {}

    int addTask(int task_id) {
        time++;
        if (cooldown[task_id] > time) {
            time = cooldown[task_id];
        }
        cooldown[task_id] = time + n;
        return time;
    }

private:
    int n;
    vector<int> cooldown;
    int time;
};