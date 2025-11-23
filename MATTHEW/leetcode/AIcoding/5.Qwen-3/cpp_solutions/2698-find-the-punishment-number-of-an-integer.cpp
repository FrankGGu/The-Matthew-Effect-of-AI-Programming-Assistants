#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    int punishmentNumber(string s) {
        int n = s.length();
        return dfs(s, 0, n - 1);
    }

private:
    bool isPerfectSquare(int num) {
        int root = sqrt(num);
        return root * root == num;
    }

    bool canSplit(string& s, int left, int right, int target) {
        if (left > right) {
            return target == 0;
        }
        for (int i = left; i <= right; ++i) {
            string sub = s.substr(left, i - left + 1);
            int val = stoi(sub);
            if (val > target) break;
            if (canSplit(s, i + 1, right, target - val)) {
                return true;
            }
        }
        return false;
    }

    int dfs(string& s, int left, int right) {
        if (left > right) return 0;
        int total = 0;
        for (int i = left; i <= right; ++i) {
            string sub = s.substr(left, i - left + 1);
            int val = stoi(sub);
            if (isPerfectSquare(val) && canSplit(s, i + 1, right, val)) {
                total += val;
            }
        }
        return total;
    }
};