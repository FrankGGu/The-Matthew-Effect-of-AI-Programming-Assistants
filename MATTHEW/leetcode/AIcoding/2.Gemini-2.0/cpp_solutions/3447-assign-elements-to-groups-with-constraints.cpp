#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int solve(int n, vector<int>& groupSizes, vector<vector<int>>& constraints) {
        int m = groupSizes.size();
        vector<int> p(n);
        for (int i = 0; i < n; ++i) {
            p[i] = i;
        }

        int count = 0;
        function<void(int)> permute = [&](int k) {
            if (k == n) {
                vector<int> assignment(n);
                for (int i = 0; i < n; ++i) {
                    assignment[i] = p[i];
                }

                vector<int> group_id(n, -1);
                vector<int> group_counts(m, 0);

                bool possible = true;
                for(int i = 0; i < n; i++){
                    int group = -1;
                    for(int j = 0; j < m; j++){
                        if(group_counts[j] < groupSizes[j]){
                            group = j;
                            break;
                        }
                    }
                    if(group == -1){
                        possible = false;
                        break;
                    }
                    group_id[assignment[i]] = group;
                    group_counts[group]++;
                }

                if(!possible) return;

                for (const auto& constraint : constraints) {
                    if (group_id[constraint[0]] == group_id[constraint[1]]) {
                        return;
                    }
                }
                count++;
                return;
            }

            for (int i = k; i < n; ++i) {
                swap(p[k], p[i]);
                permute(k + 1);
                swap(p[k], p[i]);
            }
        };

        permute(0);
        return count;
    }
};