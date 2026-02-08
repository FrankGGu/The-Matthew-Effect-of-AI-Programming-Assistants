#include <vector>
#include <unordered_map>

class FindSumPairs {
private:
    std::vector<int> n1_data;
    std::vector<int> n2_data;
    std::unordered_map<int, int> n2_counts;

public:
    FindSumPairs(std::vector<int>& nums1, std::vector<int>& nums2) {
        n1_data = nums1;
        n2_data = nums2;

        for (int x : nums2) {
            n2_counts[x]++;
        }
    }

    void add(int index, int val) {
        n2_counts[n2_data[index]]--;
        if (n2_counts[n2_data[index]] == 0) {
            n2_counts.erase(n2_data[index]);
        }

        n2_data[index] += val;

        n2_counts[n2_data[index]]++;
    }

    int count(int tot) {
        int ans = 0;
        for (int x : n1_data) {
            int target = tot - x;
            if (n2_counts.count(target)) {
                ans += n2_counts[target];
            }
        }
        return ans;
    }
};