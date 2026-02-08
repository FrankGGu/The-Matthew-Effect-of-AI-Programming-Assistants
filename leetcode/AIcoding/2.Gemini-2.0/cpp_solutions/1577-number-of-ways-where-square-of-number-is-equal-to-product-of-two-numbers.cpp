#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numTriplets(vector<int>& nums1, vector<int>& nums2) {
        int count = 0;
        count += countTriplets(nums1, nums2);
        count += countTriplets(nums2, nums1);
        return count;
    }

private:
    int countTriplets(vector<int>& nums1, vector<int>& nums2) {
        int count = 0;
        for (int i = 0; i < nums1.size(); ++i) {
            long long square = (long long)nums1[i] * nums1[i];
            unordered_map<long long, int> productCount;
            for (int j = 0; j < nums2.size(); ++j) {
                for (int k = j + 1; k < nums2.size(); ++k) {
                    long long product = (long long)nums2[j] * nums2[k];
                    if (product == square) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
};