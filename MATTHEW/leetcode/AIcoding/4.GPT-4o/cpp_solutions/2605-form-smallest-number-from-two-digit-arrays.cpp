#include <vector>
#include <string>
#include <algorithm>

using namespace std;

string minNumber(vector<int>& nums1, vector<int>& nums2) {
    sort(nums1.begin(), nums1.end());
    sort(nums2.begin(), nums2.end());

    string result;

    int i = 0, j = 0;
    while (i < nums1.size() && j < nums2.size()) {
        if (nums1[i] < nums2[j]) {
            result += to_string(nums1[i++]);
        } else {
            result += to_string(nums2[j++]);
        }
    }

    while (i < nums1.size()) {
        result += to_string(nums1[i++]);
    }

    while (j < nums2.size()) {
        result += to_string(nums2[j++]);
    }

    return result;
}