#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

string hardestWorker(int n, vector<vector<int>>& logs) {
    int maxTime = 0;
    string employee = "";
    unordered_map<int, int> workTime;
    int prevTime = 0;

    for (const auto& log : logs) {
        int id = log[0];
        int time = log[1];

        int duration = time - prevTime;
        workTime[id] += duration;

        if (workTime[id] > maxTime || (workTime[id] == maxTime && id < stoi(employee))) {
            maxTime = workTime[id];
            employee = to_string(id);
        }

        prevTime = time;
    }

    return employee;
}