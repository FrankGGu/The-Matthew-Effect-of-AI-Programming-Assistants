class Solution {
private:
    vector<int> prefixSums;
public:
    Solution(vector<int>& w) {
        prefixSums.push_back(w[0]);
        for (int i = 1; i < w.size(); ++i) {
            prefixSums.push_back(prefixSums.back() + w[i]);
        }
    }

    int pickIndex() {
        int total = prefixSums.back();
        int target = rand() % total;
        int left = 0, right = prefixSums.size() - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (prefixSums[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};