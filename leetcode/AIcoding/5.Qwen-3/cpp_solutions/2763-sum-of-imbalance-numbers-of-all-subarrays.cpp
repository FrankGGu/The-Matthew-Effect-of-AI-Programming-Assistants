#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int sumImbalanceNumbers(vector<int>& nums) {
        int n = nums.size();
        int result = 0;
        for (int i = 0; i < n; i++) {
            vector<int> s;
            int balance = 0;
            for (int j = i; j < n; j++) {
                int x = nums[j];
                int pos = -1;
                for (int k = 0; k < s.size(); k++) {
                    if (s[k] > x) {
                        pos = k;
                        break;
                    }
                }
                if (pos == -1) {
                    s.push_back(x);
                } else {
                    s.insert(s.begin() + pos, x);
                }
                int left = (pos == 0 ? -1 : s[pos - 1]);
                int right = (pos == s.size() - 1 ? -1 : s[pos + 1]);
                int new_balance = 0;
                if (left != -1 && right != -1) {
                    new_balance = min(right - x, x - left);
                } else if (left != -1) {
                    new_balance = x - left;
                } else if (right != -1) {
                    new_balance = right - x;
                } else {
                    new_balance = 0;
                }
                balance += new_balance;
                result += balance;
            }
        }
        return result;
    }
};