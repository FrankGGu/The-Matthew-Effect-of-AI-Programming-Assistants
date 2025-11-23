#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int maxHappyGroups(int batchSize, vector<int>& groups) {
        map<int, int> counts;
        for (int groupSize : groups) {
            counts[groupSize % batchSize]++;
        }

        int ans = counts[0];
        counts[0] = 0;

        vector<pair<int, int>> remaining;
        for (auto const& [key, val] : counts) {
            if (val > 0) {
                remaining.push_back({key, val});
            }
        }

        int n = remaining.size();

        if (n == 0) return ans;

        map<vector<int>, int> memo;

        function<int(vector<int>)> solve = [&](vector<int> state) {
            if (memo.count(state)) {
                return memo[state];
            }

            bool allZero = true;
            for (int count : state) {
                if (count > 0) {
                    allZero = false;
                    break;
                }
            }

            if (allZero) {
                return 0;
            }

            int maxHappiness = 0;
            for (int i = 0; i < n; ++i) {
                if (state[i] > 0) {
                    vector<int> nextState = state;
                    nextState[i]--;
                    int cur = remaining[i].first;
                    int rem = cur;

                    int happiness = 1;
                    bool possible = true;
                    for(int j = 0; j < n; ++j){
                        if(i == j) continue;
                        if(nextState[j] > 0){
                            rem = (rem + remaining[j].first) % batchSize;
                        }
                    }
                    if(rem == 0) happiness = 0;

                    maxHappiness = max(maxHappiness, happiness + solve(nextState));
                }
            }

            memo[state] = maxHappiness;
            return maxHappiness;
        };

        vector<int> initialState(n);
        for (int i = 0; i < n; ++i) {
            initialState[i] = remaining[i].second;
        }

        return ans + solve(initialState);
    }
};