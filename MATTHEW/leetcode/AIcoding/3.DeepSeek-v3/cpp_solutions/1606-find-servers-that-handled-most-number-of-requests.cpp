#include <vector>
#include <set>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> busiestServers(int k, vector<int>& arrival, vector<int>& load) {
        set<int> available;
        for (int i = 0; i < k; ++i) {
            available.insert(i);
        }
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> busy;
        vector<int> count(k, 0);

        for (int i = 0; i < arrival.size(); ++i) {
            int time = arrival[i];
            int duration = load[i];

            while (!busy.empty() && busy.top().first <= time) {
                int server = busy.top().second;
                busy.pop();
                available.insert(server);
            }

            if (available.empty()) {
                continue;
            }

            auto it = available.lower_bound(i % k);
            if (it == available.end()) {
                it = available.begin();
            }

            int server = *it;
            count[server]++;
            busy.push({time + duration, server});
            available.erase(server);
        }

        int max_req = *max_element(count.begin(), count.end());
        vector<int> result;
        for (int i = 0; i < k; ++i) {
            if (count[i] == max_req) {
                result.push_back(i);
            }
        }
        return result;
    }
};