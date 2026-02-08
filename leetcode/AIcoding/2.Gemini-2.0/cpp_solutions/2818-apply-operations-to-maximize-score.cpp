#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumScore(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> primes(n, 1);
        for (int i = 0; i < n; ++i) {
            int num = nums[i];
            for (int j = 2; j * j <= num; ++j) {
                if (num % j == 0) {
                    primes[i]++;
                    while (num % j == 0) {
                        num /= j;
                    }
                }
            }
            if (num > 1) {
                primes[i]++;
            }
        }

        vector<int> left(n), right(n);
        vector<int> st;
        for (int i = 0; i < n; ++i) {
            while (!st.empty() && primes[st.back()] < primes[i]) {
                st.pop_back();
            }
            left[i] = st.empty() ? i : i - st.back() - 1;
            st.push_back(i);
        }
        st.clear();
        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && primes[st.back()] <= primes[i]) {
                st.pop_back();
            }
            right[i] = st.empty() ? n - 1 - i : st.back() - i - 1;
            st.push_back(i);
        }

        vector<pair<int, int>> arr;
        for (int i = 0; i < n; ++i) {
            arr.push_back({primes[i], i});
        }
        sort(arr.rbegin(), arr.rend());

        long long ans = 0;
        for (int i = 0; i < n && k > 0; ++i) {
            int idx = arr[i].second;
            long long take = (long long)(left[idx] + 1) * (right[idx] + 1);
            long long cur = min((long long)k, take);
            ans += (long long)nums[idx] * cur;
            k -= cur;
        }

        return ans;
    }
};