#include <vector>
#include <string>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
private:
    bool try_remove(vector<int>& count, int rem) {
        for (int i = rem; i < 10; i += 3) {
            if (count[i] > 0) {
                count[i]--;
                return true;
            }
        }
        return false;
    }

public:
    string largestMultipleOfThree(vector<int>& digits) {
        vector<int> count(10, 0);
        int sum = 0;
        for (int d : digits) {
            count[d]++;
            sum += d;
        }

        int rem = sum % 3;
        if (rem != 0) {
            if (!try_remove(count, rem)) {
                int rem_to_remove_twice = (rem == 1) ? 2 : 1;
                if (!try_remove(count, rem_to_remove_twice) || !try_remove(count, rem_to_remove_twice)) {
                    // This case shouldn't be reachable if a solution exists
                    // but as a fallback, clear counts if we can't make sum divisible by 3
                    fill(count.begin(), count.end(), 0);
                }
            }
        }

        string res = "";
        for (int i = 9; i >= 0; i--) {
            res += string(count[i], '0' + i);
        }

        if (!res.empty() && res[0] == '0') {
            return "0";
        }

        return res;
    }
};