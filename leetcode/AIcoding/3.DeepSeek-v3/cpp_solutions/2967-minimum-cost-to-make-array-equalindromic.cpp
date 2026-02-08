#include <vector>
#include <algorithm>
#include <climits>
#include <cmath>

using namespace std;

class Solution {
public:
    bool isPalindromic(int num) {
        if (num < 0) return false;
        int reversed = 0, original = num;
        while (num > 0) {
            reversed = reversed * 10 + num % 10;
            num /= 10;
        }
        return original == reversed;
    }

    long long nearestPalindromic(int num) {
        long long n = num;
        if (n < 10) return n;
        string s = to_string(n);
        int len = s.size();
        vector<long long> candidates;
        candidates.push_back(pow(10, len) + 1);
        candidates.push_back(pow(10, len - 1) - 1);
        long long prefix = stol(s.substr(0, (len + 1) / 2));
        for (long long i = prefix - 1; i <= prefix + 1; ++i) {
            string left = to_string(i);
            string right = left.substr(0, left.size() - (len % 2));
            reverse(right.begin(), right.end());
            candidates.push_back(stol(left + right));
        }
        long long minDiff = LLONG_MAX, result = n;
        for (long long candidate : candidates) {
            if (candidate == n) continue;
            long long diff = abs(candidate - n);
            if (diff < minDiff || (diff == minDiff && candidate < result)) {
                minDiff = diff;
                result = candidate;
            }
        }
        return result;
    }

    long long makeSubArrayEqual(vector<int>& nums, int left, int right, int target) {
        long long cost = 0;
        for (int i = left; i <= right; ++i) {
            cost += abs(nums[i] - target);
        }
        return cost;
    }

    long long minimumCost(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int median = nums[n / 2];
        long long minCost = LLONG_MAX;
        for (int delta = -1; delta <= 1; ++delta) {
            int candidate = median + delta;
            if (isPalindromic(candidate)) {
                long long cost = makeSubArrayEqual(nums, 0, n - 1, candidate);
                if (cost < minCost) {
                    minCost = cost;
                }
            }
        }
        int candidate = nearestPalindromic(median);
        if (isPalindromic(candidate)) {
            long long cost = makeSubArrayEqual(nums, 0, n - 1, candidate);
            if (cost < minCost) {
                minCost = cost;
            }
        }
        return minCost;
    }
};