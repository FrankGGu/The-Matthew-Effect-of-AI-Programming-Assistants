#include <vector>
#include <unordered_map>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int busRapidTransit(int target, int inc, int dec, vector<int>& jump, vector<int>& cost) {
        unordered_map<long, long> memo;
        priority_queue<pair<long, long>, vector<pair<long, long>>, greater<pair<long, long>>> pq;
        pq.push({0, target});
        memo[target] = 0;

        long res = LONG_MAX;

        while (!pq.empty()) {
            auto [time, pos] = pq.top();
            pq.pop();

            if (pos == 0) {
                return time;
            }

            if (time >= res) {
                continue;
            }

            res = min(res, time + pos * inc);

            for (int i = 0; i < jump.size(); ++i) {
                int j = jump[i];
                long c = cost[i];
                long next_pos = pos / j;
                long remainder = pos % j;

                if (remainder == 0) {
                    if (memo.find(next_pos) == memo.end() || time + c < memo[next_pos]) {
                        memo[next_pos] = time + c;
                        pq.push({time + c, next_pos});
                    }
                } else {
                    long time1 = time + c + remainder * inc;
                    if (memo.find(next_pos) == memo.end() || time + c + remainder * inc < memo[next_pos]) {
                        memo[next_pos] = time + c + remainder * inc;
                        pq.push({time + c + remainder * inc, next_pos});
                    }

                    long time2 = time + c + (j - remainder) * dec;
                    if (memo.find(next_pos + 1) == memo.end() || time + c + (j - remainder) * dec < memo[next_pos + 1]) {
                        memo[next_pos + 1] = time + c + (j - remainder) * dec;
                        pq.push({time + c + (j - remainder) * dec, next_pos + 1});
                    }
                }
            }
        }

        return res;
    }
};