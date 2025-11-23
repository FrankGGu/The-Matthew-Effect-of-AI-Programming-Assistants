class Solution {
public:
    int countBeautifulSplits(vector<int>& nums) {
        int n = nums.size();
        vector<int> left(n), right(n);
        unordered_map<int, int> leftFreq, rightFreq;

        for (int i = 0; i < n; ++i) {
            leftFreq[nums[i]]++;
            left[i] = leftFreq.size();
        }

        for (int i = n - 1; i >= 0; --i) {
            rightFreq[nums[i]]++;
            right[i] = rightFreq.size();
        }

        int count = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (left[i] == right[i + 1]) {
                count++;
            }
        }

        return count;
    }
};