#include <iostream>
#include <vector>
#include <queue>
#include <set>

using namespace std;

class Solution {
private:
    int m, k;
    vector<int> nums;
    set<int> left;
    set<int> mid;
    set<int> right;
    long long sumMid;

public:
    Solution(int m, int k) : m(m), k(k), sumMid(0) {}

    void add(int num) {
        nums.push_back(num);
        if (nums.size() < m) return;

                if (nums.size() == m) {
            for (int i = 0; i < k; ++i) {
                mid.insert(nums[i]);
            }
            sumMid = 0;
            for (auto it = mid.begin(); it != mid.end(); ++it) {
                sumMid += *it;
            }
            return;
        }

                if (num < *mid.begin()) {
            left.insert(num);
        } else if (num > *mid.rbegin()) {
            right.insert(num);
        } else {
            mid.insert(num);
            sumMid += num;
        }

                while (left.size() > m - k) {
            int val = *left.rbegin();
            left.erase(val);
            mid.insert(val);
            sumMid += val;
        }

        while (mid.size() > k) {
            int val = *mid.begin();
            mid.erase(val);
            sumMid -= val;
            if (right.empty()) {
                left.insert(val);
            } else {
                right.insert(val);
            }
        }

        while (right.size() > m - k) {
            int val = *right.begin();
            right.erase(val);
            mid.insert(val);
            sumMid += val;
        }
    }

    int getMkAverage() {
        if (nums.size() < m) return -1;
        return sumMid / k;
    }
};