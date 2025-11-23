#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> splitIntoFibonacci(string s) {
        vector<int> res;
        function<bool(int)> backtrack = [&](int start) {
            if (start == s.size() && res.size() >= 3) {
                return true;
            }

            for (int i = start; i < s.size(); ++i) {
                if (s[start] == '0' && i > start) {
                    break;
                }

                long long num = stoll(s.substr(start, i - start + 1));
                if (num > INT_MAX) {
                    break;
                }

                int n = res.size();
                if (n >= 2 && (long long)res[n - 1] + (long long)res[n - 2] < num) {
                    break;
                }

                if (n < 2 || (long long)res[n - 1] + (long long)res[n - 2] == num) {
                    res.push_back((int)num);
                    if (backtrack(i + 1)) {
                        return true;
                    }
                    res.pop_back();
                }
            }
            return false;
        };

        if (backtrack(0)) {
            return res;
        } else {
            return {};
        }
    }
};