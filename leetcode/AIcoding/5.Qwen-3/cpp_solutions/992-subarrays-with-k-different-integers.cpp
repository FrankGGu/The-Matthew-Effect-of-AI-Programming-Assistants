#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int subarraysWithKDifferentIntegers(vector<int>& A, int K) {
        auto atMost = [&](int k) {
            int count = 0;
            int left = 0;
            unordered_map<int, int> freq;
            for (int right = 0; right < A.size(); ++right) {
                freq[A[right]]++;
                while (freq.size() > k) {
                    freq[A[left]]--;
                    if (freq[A[left]] == 0) {
                        freq.erase(A[left]);
                    }
                    left++;
                }
                count += right - left + 1;
            }
            return count;
        };
        return atMost(K) - atMost(K - 1);
    }
};