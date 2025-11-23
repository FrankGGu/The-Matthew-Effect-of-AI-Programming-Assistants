class Solution {
public:
    vector<int> maxNumber(vector<int>& nums1, vector<int>& nums2, int k) {
        vector<int> result;
        for (int i = max(0, k - (int)nums2.size()); i <= min(k, (int)nums1.size()); ++i) {
            vector<int> max1 = getMaxArray(nums1, i);
            vector<int> max2 = getMaxArray(nums2, k - i);
            result = max(result, merge(max1, max2));
        }
        return result;
    }

private:
    vector<int> getMaxArray(vector<int>& nums, int size) {
        vector<int> drop;
        int dropCount = nums.size() - size;
        for (int num : nums) {
            while (!drop.empty() && drop.back() < num && dropCount > 0) {
                drop.pop_back();
                dropCount--;
            }
            drop.push_back(num);
        }
        drop.resize(size);
        return drop;
    }

    vector<int> merge(vector<int>& a, vector<int>& b) {
        vector<int> result;
        while (!a.empty() || !b.empty()) {
            if (a > b) {
                result.push_back(a.front());
                a.erase(a.begin());
            } else {
                result.push_back(b.front());
                b.erase(b.begin());
            }
        }
        return result;
    }
};