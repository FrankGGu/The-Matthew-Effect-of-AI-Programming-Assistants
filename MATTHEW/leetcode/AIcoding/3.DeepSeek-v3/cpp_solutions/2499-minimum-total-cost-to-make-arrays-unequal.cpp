class Solution {
public:
    long long minimumTotalCost(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        long long res = 0;
        int total = 0;
        int dominant = -1;
        int dominant_cnt = 0;
        unordered_map<int, int> freq;

        for (int i = 0; i < n; ++i) {
            if (nums1[i] == nums2[i]) {
                res += i;
                total++;
                freq[nums1[i]]++;
                if (freq[nums1[i]] > dominant_cnt) {
                    dominant_cnt = freq[nums1[i]];
                    dominant = nums1[i];
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            if (dominant_cnt * 2 > total && nums1[i] != nums2[i] && nums1[i] != dominant && nums2[i] != dominant) {
                res += i;
                total++;
            }
        }

        if (dominant_cnt * 2 > total) {
            return -1;
        } else {
            return res;
        }
    }
};