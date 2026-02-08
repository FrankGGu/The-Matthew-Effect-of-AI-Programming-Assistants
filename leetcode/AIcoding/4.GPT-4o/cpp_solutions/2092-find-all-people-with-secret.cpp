class Solution {
public:
    vector<int> findAllPeople(int n, vector<vector<int>>& meetings, int firstPerson) {
        vector<int> res;
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& m : meetings) {
            graph[m[0]].emplace_back(m[1], m[2]);
            graph[m[1]].emplace_back(m[0], m[2]);
        }

        sort(meetings.begin(), meetings.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });

        vector<bool> knowsSecret(n, false);
        knowsSecret[0] = knowsSecret[firstPerson] = true;

        int i = 0;
        while (i < meetings.size()) {
            int time = meetings[i][2];
            vector<int> currentPeople;

            while (i < meetings.size() && meetings[i][2] == time) {
                currentPeople.push_back(meetings[i][0]);
                currentPeople.push_back(meetings[i][1]);
                i++;
            }

            unordered_set<int> currentSet(currentPeople.begin(), currentPeople.end());
            vector<int> toSpread;

            for (int person : currentPeople) {
                if (knowsSecret[person]) {
                    toSpread.push_back(person);
                }
            }

            for (int person : toSpread) {
                for (const auto& neighbor : graph[person]) {
                    if (currentSet.count(neighbor.first)) {
                        knowsSecret[neighbor.first] = true;
                    }
                }
            }
        }

        for (int i = 0; i < n; i++) {
            if (knowsSecret[i]) {
                res.push_back(i);
            }
        }

        return res;
    }
};