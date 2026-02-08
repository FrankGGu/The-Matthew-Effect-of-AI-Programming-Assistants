#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumSubsequenceCount(string text, string pattern) {
        long long count1 = 0, count2 = 0;
        long long res1 = 0, res2 = 0;

        for (char c : text) {
            if (c == pattern[1]) {
                res1 += count1;
                count2++;
            }
            if (c == pattern[0]) {
                count1++;
            }
        }

        long long temp_count1 = 0, temp_count2 = 0;
        long long temp_res2 = 0;

        for (char c : text) {
            if (c == pattern[1]) {
                temp_res2 += temp_count1;
                temp_count2++;
            }
            if (c == pattern[0]) {
                temp_count1++;
            }
        }
        temp_count1++;

        long long res_add_first = 0;
        long long first_count1 = 1;
        long long first_count2 = 0;

        if (pattern[0] == pattern[1]) {
            res_add_first = (temp_count1 * (temp_count1 - 1)) / 2;
        } else {
            for (char c : text) {
                if (c == pattern[1]) {
                    res_add_first += first_count1;
                    first_count2++;
                }
                if (c == pattern[0]) {
                    first_count1++;
                }
            }
        }

        long long temp_count1_last = 0, temp_count2_last = 0;
        long long temp_res2_last = 0;

         for (char c : text) {
            if (c == pattern[1]) {
                temp_res2_last += temp_count1_last;
                temp_count2_last++;
            }
            if (c == pattern[0]) {
                temp_count1_last++;
            }
        }
        temp_count2_last++;

        long long res_add_last = 0;
        long long last_count1 = 0;
        long long last_count2 = 1;

        if (pattern[0] == pattern[1]) {
            res_add_last = (temp_count2_last * (temp_count2_last - 1)) / 2;
        } else {
            for (char c : text) {
                if (c == pattern[1]) {
                    res_add_last += last_count1;
                    last_count2++;
                }
                if (c == pattern[0]) {
                    last_count1++;
                }
            }
        }

        return max(res_add_first, res_add_last);
    }
};