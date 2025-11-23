#include <unordered_map>
#include <vector>

using namespace std;

class FindSumPairs {
public:
    FindSumPairs(vector<int>& nums1, vector<int>& nums2) : nums1_(nums1), nums2_(nums2) {
        for (int num : nums2_) {
            counts_[num]++;
        }
    }

    void add(int index, int val) {
        counts_[nums2_[index]]--;
        nums2_[index] += val;
        counts_[nums2_[index]]++;
    }

    int count(int tot) {
        int result = 0;
        for (int num : nums1_) {
            int complement = tot - num;
            if (counts_.count(complement)) {
                result += counts_[complement];
            }
        }
        return result;
    }

private:
    vector<int>& nums1_;
    vector<int>& nums2_;
    unordered_map<int, int> counts_;
};