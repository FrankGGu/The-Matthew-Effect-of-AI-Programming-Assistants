#include <vector>
#include <algorithm>

using namespace std;

long long minOperations(vector<int>& nums1, vector<int>& nums2) {
    vector<int> odd1, even1, odd2, even2;
    for (int num : nums1) {
        if (num % 2 == 0) {
            even1.push_back(num);
        } else {
            odd1.push_back(num);
        }
    }
    for (int num : nums2) {
        if (num % 2 == 0) {
            even2.push_back(num);
        } else {
            odd2.push_back(num);
        }
    }
    sort(odd1.begin(), odd1.end());
    sort(even1.begin(), even1.end());
    sort(odd2.begin(), odd2.end());
    sort(even2.begin(), even2.end());

    long long ans = 0;
    for (int i = 0; i < odd1.size(); ++i) {
        ans += abs(odd1[i] - odd2[i]) / 2;
    }
    for (int i = 0; i < even1.size(); ++i) {
        ans += abs(even1[i] - even2[i]) / 2;
    }

    return ans / 2;
}