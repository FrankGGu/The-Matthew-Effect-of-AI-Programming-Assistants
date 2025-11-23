#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    long long minimumTotalCost(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        vector<int> indices;
        int common = -1, commonCount = 0;
        long long cost = 0;

        for (int i = 0; i < n; ++i) {
            if (nums1[i] == nums2[i]) {
                indices.push_back(i);
                cost += i;
                if (common == -1) {
                    common = nums1[i];
                    commonCount = 1;
                } else if (common == nums1[i]) {
                    commonCount++;
                } else {
                    int count1 = 0, count2 = 0;
                    for(int j = 0; j < i; ++j){
                        if(nums1[j] == nums1[i]) count1++;
                        if(nums2[j] == nums1[i]) count2++;
                    }
                    if(count1 + count2 > 0) commonCount++;
                }
            }
        }

        if (common == -1) return 0;

        int need = (indices.size() + 1) / 2;
        if (commonCount < need) return -1;

        int replaced = 0;
        for (int i = 0; i < n && replaced < indices.size() - need; ++i) {
            if (nums1[i] != common && nums2[i] != common) {
                cost -= indices.back();
                cost += i;
                indices.pop_back();
                replaced++;
            }
        }

        return cost;
    }
};