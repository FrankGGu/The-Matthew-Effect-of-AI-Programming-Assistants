#include <vector>
#include <unordered_map>

using namespace std;

long long countGood(vector<int>& nums, int k) {
    long long count = 0;
    unordered_map<int, int> freq;
    int left = 0;
    long long pairs = 0;

    for (int right = 0; right < nums.size(); ++right) {
        pairs -= (long long)freq[nums[right]] * (freq[nums[right]] - 1) / 2;
        freq[nums[right]]++;
        pairs += (long long)freq[nums[right]] * (freq[nums[right]] - 1) / 2;

        while (pairs >= k) {
            count += nums.size() - right;
            pairs -= (long long)freq[nums[left]] * (freq[nums[left]] - 1) / 2;
            freq[nums[left]]--;
            pairs += (long long)freq[nums[left]] * (freq[nums[left]] - 1) / 2;
            left++;
        }
    }

    return count;
}