class Solution {
public:
    int threeSumMulti(vector<int>& arr, int target) {
        int count = 0;
        const int MOD = 1e9 + 7;
        sort(arr.begin(), arr.end());
        int n = arr.size();

        for (int i = 0; i < n; ++i) {
            int j = i + 1, k = n - 1;
            while (j < k) {
                int sum = arr[i] + arr[j] + arr[k];
                if (sum < target) {
                    ++j;
                } else if (sum > target) {
                    --k;
                } else {
                    if (arr[j] == arr[k]) {
                        count = (count + (k - j + 1) * (k - j)) / 2 % MOD;
                        break;
                    }
                    int leftCount = 1, rightCount = 1;
                    while (j < k && arr[j] == arr[j + 1]) {
                        ++leftCount;
                        ++j;
                    }
                    while (j < k && arr[k] == arr[k - 1]) {
                        ++rightCount;
                        --k;
                    }
                    count = (count + leftCount * rightCount) % MOD;
                    ++j;
                    --k;
                }
            }
        }
        return count;
    }
};