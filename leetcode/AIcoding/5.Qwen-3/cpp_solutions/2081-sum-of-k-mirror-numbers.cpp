#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    long long sumKMirror(int k, int n) {
        vector<long long> result;
        long long num = 1;
        while (result.size() < n) {
            string s = to_string(num);
            if (isPalindrome(s)) {
                long long val = 0;
                for (char c : s) {
                    val = val * k + (c - '0');
                }
                result.push_back(val);
            }
            num++;
        }
        long long sum = 0;
        for (int i = 0; i < n; i++) {
            sum += result[i];
        }
        return sum;
    }

private:
    bool isPalindrome(const string& s) {
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (s[left] != s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
};