#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> splitMessage(string message, int limit) {
        int n = message.size();
        int k = 0;
        int len_k = 1;
        int count = 0;

        while (true) {
            int possible_k = 9 * pow(10, len_k - 1);
            int prefix_len = to_string(k + possible_k).size() + 3;
            int possible_len = limit - prefix_len;

            if (possible_len <= 0) {
                len_k++;
                continue;
            }

            long long total_len = (long long)possible_len * possible_k;
            if (total_len >= n) {
                k += possible_k;
                break;
            }
            n -= possible_len * possible_k;
            k += possible_k;
            len_k++;
        }

        vector<string> res;
        int start = 0;
        for (int i = 1; i <= k; ++i) {
            string prefix = "<" + to_string(i) + "/" + to_string(k) + ">";
            int remaining = limit - prefix.size();
            res.push_back(message.substr(start, remaining) + prefix);
            start += remaining;
        }

        return res;
    }
};