class Solution {
public:
    vector<int> busiestServers(int k, vector<int>& arrival, vector<int>& load) {
        vector<int> count(k, 0);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> busy;
        vector<int> result;

        for (int i = 0; i < arrival.size(); ++i) {
            while (!busy.empty() && busy.top().first <= arrival[i]) {
                busy.pop();
            }
            int idx = i % k;
            if (busy.empty() && count[idx] == 0) {
                busy.push({arrival[i] + load[i], idx});
                count[idx]++;
            } else {
                if (busy.empty()) continue;
                if (count[idx] == 0) {
                    if (busy.top().first <= arrival[i]) {
                        busy.push({arrival[i] + load[i], idx});
                        count[idx]++;
                    }
                } else {
                    busy.push({arrival[i] + load[i], idx});
                    count[idx]++;
                }
            }
            while (!busy.empty() && busy.top().first <= arrival[i]) {
                busy.pop();
            }
        }

        int maxCount = *max_element(count.begin(), count.end());
        for (int i = 0; i < k; ++i) {
            if (count[i] == maxCount) {
                result.push_back(i);
            }
        }

        return result;
    }
};