#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int threeSumMulti(vector<int>& arr, int target) {
        int MOD = 1e9 + 7;
        long long count = 0;
        sort(arr.begin(), arr.end());
        int n = arr.size();

        for (int i = 0; i < n - 2; ++i) {
            int j = i + 1;
            int k = n - 1;

            while (j < k) {
                int sum = arr[i] + arr[j] + arr[k];

                if (sum < target) {
                    ++j;
                } else if (sum > target) {
                    --k;
                } else {
                    if (arr[j] == arr[k]) {
                        long long num = k - j + 1;
                        count = (count + (num * (num - 1) / 2)) % MOD;
                        break;
                    } else {
                        int left = 1;
                        while (j + left < k && arr[j + left] == arr[j]) {
                            ++left;
                        }

                        int right = 1;
                        while (k - right > j && arr[k - right] == arr[k]) {
                            ++right;
                        }

                        count = (count + (long long)left * right) % MOD;
                        j += left;
                        k -= right;
                    }
                }
            }
        }

        return (int)count;
    }
};