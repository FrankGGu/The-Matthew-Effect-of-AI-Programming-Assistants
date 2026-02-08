#include <vector>
#include <map>

class Solution {
public:
    long long numberOfTriplets(std::vector<int>& nums1, std::vector<int>& nums2) {
        long long totalWays = 0;
        totalWays += countTripletsOfType(nums1, nums2);
        totalWays += countTripletsOfType(nums2, nums1);
        return totalWays;
    }

private:
    long long countTripletsOfType(std::vector<int>& arr1, std::vector<int>& arr2) {
        long long ways = 0;
        std::map<int, int> freq2;
        for (int x : arr2) {
            freq2[x]++;
        }

        for (int i = 0; i < arr1.size(); ++i) {
            long long target = (long long)arr1[i] * arr1[i];

            for (int j = 0; j < arr2.size(); ++j) {
                int num_j = arr2[j];
                if (target % num_j == 0) {
                    long long num_k = target / num_j;
                    if (freq2.count(num_k)) {
                        ways += freq2[num_k];
                    }
                }
            }
        }
        return ways;
    }
};