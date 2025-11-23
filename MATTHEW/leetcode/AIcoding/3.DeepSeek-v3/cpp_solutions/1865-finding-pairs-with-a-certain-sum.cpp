class FindSumPairs {
public:
    vector<int> nums1, nums2;
    unordered_map<int, int> freq;

    FindSumPairs(vector<int>& nums1, vector<int>& nums2) {
        this->nums1 = nums1;
        this->nums2 = nums2;
        for (int num : nums2) {
            freq[num]++;
        }
    }

    void add(int index, int val) {
        freq[nums2[index]]--;
        nums2[index] += val;
        freq[nums2[index]]++;
    }

    int count(int tot) {
        int res = 0;
        for (int num : nums1) {
            res += freq[tot - num];
        }
        return res;
    }
};