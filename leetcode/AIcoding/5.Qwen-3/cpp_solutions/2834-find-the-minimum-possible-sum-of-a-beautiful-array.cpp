#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long findMinimumPossibleSum(int n, int k) {
        vector<int> a(n);
        unordered_map<int, int> freq;
        for (int i = 0; i < n; ++i) {
            a[i] = i + 1;
        }
        for (int i = 0; i < n; ++i) {
            if (freq.find(a[i]) != freq.end()) {
                continue;
            }
            freq[a[i]] = 1;
            for (int j = i + 1; j < n; ++j) {
                if (a[j] - a[i] == k) {
                    a[j] += 1;
                    while (freq.find(a[j]) != freq.end()) {
                        a[j]++;
                    }
                    freq[a[j]] = 1;
                }
            }
        }
        long long sum = 0;
        for (int i = 0; i < n; ++i) {
            sum += a[i];
        }
        return sum;
    }
};