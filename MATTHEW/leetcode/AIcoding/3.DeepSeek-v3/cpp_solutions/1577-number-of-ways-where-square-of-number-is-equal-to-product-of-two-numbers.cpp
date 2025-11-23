class Solution {
public:
    int numTriplets(vector<int>& nums1, vector<int>& nums2) {
        return countTriplets(nums1, nums2) + countTriplets(nums2, nums1);
    }

private:
    int countTriplets(vector<int>& nums1, vector<int>& nums2) {
        unordered_map<long, int> squareCount;
        for (int num : nums1) {
            long square = (long)num * num;
            squareCount[square]++;
        }

        int res = 0;
        for (int j = 0; j < nums2.size(); ++j) {
            for (int k = j + 1; k < nums2.size(); ++k) {
                long product = (long)nums2[j] * nums2[k];
                if (squareCount.find(product) != squareCount.end()) {
                    res += squareCount[product];
                }
            }
        }
        return res;
    }
};