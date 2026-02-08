#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long countPowerfulIntegers(long long start, long long finish, int limit, string s) {
        string s_finish = to_string(finish);
        int n = s.length();
        int m = s_finish.length();

        if (m < n) return 0;

        long long ans = solve(s_finish, start, limit, s);
        return ans;
    }

private:
    long long solve(string& num, long long start, int limit, string& s) {
        int n = s.length();
        int m = num.length();
        string prefix = num.substr(0, m - n);

        long long ans = 0;
        long long prefix_num = stoll(prefix);

        for (long long i = 0; i <= prefix_num; ++i) {
            string current_prefix = to_string(i);
            string current_num = current_prefix;
            while (current_num.length() < m - n) {
                current_num = "0" + current_num;
            }
            current_num += s;
            long long current_val = stoll(current_num);

            if (current_val >= start && current_val <= stoll(num)) {
                 bool valid = true;
                for (int j = 0; j < current_prefix.length(); ++j) {
                    if (current_prefix[j] - '0' > limit) {
                        valid = false;
                        break;
                    }
                }
                if(valid) ans++;
            }
        }

        return ans;
    }
};