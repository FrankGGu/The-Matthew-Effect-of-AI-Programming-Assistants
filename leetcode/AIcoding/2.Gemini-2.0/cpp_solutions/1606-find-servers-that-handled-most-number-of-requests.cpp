#include <vector>
#include <queue>
#include <set>

using namespace std;

class Solution {
public:
    vector<int> busiestServers(int k, vector<int>& arrival, vector<int>& duration) {
        vector<int> requests(k, 0);
        set<int> available;
        for (int i = 0; i < k; ++i) {
            available.insert(i);
        }

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> busy;

        for (int i = 0; i < arrival.size(); ++i) {
            while (!busy.empty() && busy.top().first <= arrival[i]) {
                available.insert(busy.top().second);
                busy.pop();
            }

            if (available.empty()) continue;

            int server = i % k;
            auto it = available.lower_bound(server);
            if (it == available.end()) {
                it = available.begin();
            }

            server = *it;
            requests[server]++;
            available.erase(it);
            busy.push({arrival[i] + duration[i], server});
        }

        int maxRequests = 0;
        for (int i = 0; i < k; ++i) {
            maxRequests = max(maxRequests, requests[i]);
        }

        vector<int> result;
        for (int i = 0; i < k; ++i) {
            if (requests[i] == maxRequests) {
                result.push_back(i);
            }
        }

        return result;
    }
};