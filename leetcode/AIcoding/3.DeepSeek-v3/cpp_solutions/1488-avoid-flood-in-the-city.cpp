class Solution {
public:
    vector<int> avoidFlood(vector<int>& rains) {
        unordered_map<int, int> lastRain;
        set<int> dryDays;
        vector<int> result(rains.size(), -1);

        for (int i = 0; i < rains.size(); ++i) {
            if (rains[i] == 0) {
                dryDays.insert(i);
                result[i] = 1;
            } else {
                if (lastRain.count(rains[i])) {
                    auto it = dryDays.upper_bound(lastRain[rains[i]]);
                    if (it == dryDays.end()) {
                        return {};
                    }
                    result[*it] = rains[i];
                    dryDays.erase(it);
                }
                lastRain[rains[i]] = i;
            }
        }
        return result;
    }
};