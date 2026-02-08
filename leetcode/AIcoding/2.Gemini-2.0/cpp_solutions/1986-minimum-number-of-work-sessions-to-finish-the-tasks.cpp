#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSessions(vector<int>& tasks, int sessionTime) {
        int n = tasks.size();
        int ans = n;
        for (int mask = 0; mask < (1 << n); ++mask) {
            int sessions = 0;
            vector<bool> used(n, false);
            vector<int> current_session;

            function<void(int, int)> solve = [&](int index, int current_mask) {
                if (index == n) {
                    if (current_mask == (1 << n) - 1) {
                        ans = min(ans, sessions);
                    }
                    return;
                }

                if (current_mask == (1 << n) - 1) {
                    ans = min(ans, sessions);
                    return;
                }

                if (sessions >= ans) return;

                bool all_used = true;
                for(int i = 0; i < n; ++i) {
                    if(!used[i]) {
                        all_used = false;
                        break;
                    }
                }

                if(all_used) {
                    ans = min(ans, sessions);
                    return;
                }

                bool new_session_needed = true;
                for (int i = 0; i < n; ++i) {
                    if (!used[i] && tasks[i] <= sessionTime) {
                        new_session_needed = false;
                        break;
                    }
                }

                if (new_session_needed) {
                    sessions++;
                    vector<bool> temp_used = used;
                    solve(0, current_mask);
                    sessions--;

                } else {
                    for (int i = 0; i < n; ++i) {
                        if (!used[i]) {
                            int current_time = 0;
                            vector<int> current_tasks;

                            function<void(int, int, int)> solve_session = [&](int idx, int current_sum, int session_mask) {
                                if (idx == n) {
                                    if (session_mask > 0) {
                                        sessions++;
                                        vector<bool> temp_used = used;
                                        for (int j = 0; j < n; ++j) {
                                            if ((session_mask & (1 << j)) != 0) {
                                                used[j] = true;
                                            }
                                        }
                                        solve(0, current_mask | session_mask);
                                        sessions--;
                                        used = temp_used;
                                    }
                                    return;
                                }

                                if (current_sum > sessionTime) return;

                                if (idx > i && session_mask == 0) return;

                                solve_session(idx + 1, current_sum, session_mask);

                                if (!used[idx]) {
                                    solve_session(idx + 1, current_sum + tasks[idx], session_mask | (1 << idx));
                                }
                            };
                            solve_session(0, 0, 0);
                            return;
                        }
                    }
                }
            };

            solve(0, 0);
        }
        return ans;
    }
};