#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    int getMaxRepetitions(std::string s1, int n1, std::string s2, int n2) {
        if (n1 == 0) {
            return 0;
        }

        int s1_len = s1.length();
        int s2_len = s2.length();

        std::vector<long long> s1_reps_at_s2_idx(s2_len + 1, -1LL);
        std::vector<long long> s2_reps_at_s2_idx(s2_len + 1, -1LL);

        long long current_s1_reps = 0;
        long long current_s2_reps = 0;
        int s2_ptr = 0; 

        bool cycle_found = false;

        while (current_s1_reps < n1) {
            for (int i = 0; i < s1_len; ++i) {
                if (s1[i] == s2[s2_ptr]) {
                    s2_ptr++;
                    if (s2_ptr == s2_len) {
                        current_s2_reps++;
                        s2_ptr = 0;
                    }
                }
            }
            current_s1_reps++;

            if (!cycle_found) {
                if (s1_reps_at_s2_idx[s2_ptr] != -1LL) {
                    cycle_found = true;
                    long long prev_s1_reps = s1_reps_at_s2_idx[s2_ptr];
                    long long prev_s2_reps = s2_reps_at_s2_idx[s2_ptr];

                    long long s1_cycle_len = current_s1_reps - prev_s1_reps;
                    long long s2_cycle_len = current_s2_reps - prev_s2_reps;

                    long long remaining_s1_reps = n1 - current_s1_reps;
                    long long num_full_cycles = remaining_s1_reps / s1_cycle_len;

                    current_s2_reps += num_full_cycles * s2_cycle_len;
                    current_s1_reps += num_full_cycles * s1_cycle_len;
                } else {
                    s1_reps_at_s2_idx[s2_ptr] = current_s1_reps;
                    s2_reps_at_s2_idx[s2_ptr] = current_s2_reps;
                }
            }
        }

        return static_cast<int>(current_s2_reps / n2);
    }
};