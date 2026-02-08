#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long taskSchedulerII(vector<int>& tasks, int space) {
        unordered_map<int, long long> last_executed;
        long long current_day = 0;

        for (int task : tasks) {
            current_day++;
            if (last_executed.count(task) > 0) {
                long long next_available = last_executed[task] + space + 1;
                if (next_available > current_day) {
                    current_day = next_available;
                }
            }
            last_executed[task] = current_day;
        }

        return current_day;
    }
};