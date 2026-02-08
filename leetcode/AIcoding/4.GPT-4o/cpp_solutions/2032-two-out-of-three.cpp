#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

vector<int> twoOutOfThree(vector<int>& nums1, vector<int>& nums2, vector<int>& nums3) {
    unordered_map<int, int> count;
    unordered_set<int> unique1(nums1.begin(), nums1.end());
    unordered_set<int> unique2(nums2.begin(), nums2.end());
    unordered_set<int> unique3(nums3.begin(), nums3.end());

    for (int num : unique1) count[num]++;
    for (int num : unique2) count[num]++;
    for (int num : unique3) count[num]++;

    vector<int> result;
    for (const auto& [num, c] : count) {
        if (c > 1) result.push_back(num);
    }

    return result;
}