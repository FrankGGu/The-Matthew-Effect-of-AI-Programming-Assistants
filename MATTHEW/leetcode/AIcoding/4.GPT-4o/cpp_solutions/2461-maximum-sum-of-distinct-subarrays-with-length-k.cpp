class Solution {
public:
    int maximumSum(vector<int>& arr, int k) {
        unordered_set<int> seen;
        int maxSum = 0, currentSum = 0;

        for (int i = 0; i < arr.size(); ++i) {
            if (i >= k) {
                if (seen.count(arr[i - k]) > 0) {
                    seen.erase(arr[i - k]);
                    currentSum -= arr[i - k];
                }
            }

            if (seen.count(arr[i]) == 0) {
                seen.insert(arr[i]);
                currentSum += arr[i];
            } else {
                currentSum = 0;
                seen.clear();
                for (int j = i; j < i + k && j < arr.size(); ++j) {
                    if (seen.count(arr[j]) == 0) {
                        seen.insert(arr[j]);
                        currentSum += arr[j];
                    } else {
                        currentSum = 0;
                        break;
                    }
                }
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                }
            }

            if (i >= k - 1 && seen.size() == k) {
                maxSum = max(maxSum, currentSum);
            }
        }

        return maxSum;
    }
};