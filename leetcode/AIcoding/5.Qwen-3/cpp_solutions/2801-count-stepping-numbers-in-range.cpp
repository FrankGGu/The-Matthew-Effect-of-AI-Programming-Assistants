#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> countSteppingNumbers(string low, string high) {
        vector<int> result;
        int n = high.length();
        for (int i = 0; i < n; ++i) {
            if (i > 0 && high[i] == '0') continue;
            if (i == 0 && high[i] == '0') continue;
            vector<bool> used(10, false);
            string curr;
            dfs(high, low, i, 0, curr, used, result);
        }
        return result;
    }

private:
    void dfs(const string& high, const string& low, int start, int pos, string& curr, vector<bool>& used, vector<int>& result) {
        if (pos == high.length()) {
            if (curr.length() >= low.length() && curr.length() <= high.length()) {
                if (curr.length() > low.length() || (curr.length() == low.length() && curr >= low)) {
                    result.push_back(stoi(curr));
                }
            }
            return;
        }

        for (int i = 0; i <= 9; ++i) {
            if (used[i]) continue;
            if (pos == 0) {
                if (i == 0) continue;
                used[i] = true;
                curr.push_back(i + '0');
                dfs(high, low, i, pos + 1, curr, used, result);
                curr.pop_back();
                used[i] = false;
            } else {
                if (abs(i - (curr.back() - '0')) != 1) continue;
                used[i] = true;
                curr.push_back(i + '0');
                dfs(high, low, i, pos + 1, curr, used, result);
                curr.pop_back();
                used[i] = false;
            }
        }
    }
};