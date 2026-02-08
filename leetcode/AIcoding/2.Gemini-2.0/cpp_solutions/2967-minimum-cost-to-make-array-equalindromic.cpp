#include <vector>
#include <algorithm>

using namespace std;

long long getCost(vector<int>& nums, int target) {
    long long cost = 0;
    for (int num : nums) {
        cost += abs(num - target);
    }
    return cost;
}

bool isPalindrome(int num) {
    if (num < 0) return false;
    string s = to_string(num);
    string reversed_s = s;
    reverse(reversed_s.begin(), reversed_s.end());
    return s == reversed_s;
}

int getNextPalindrome(int num) {
    if (num < 0) return -1;
    num++;
    while (!isPalindrome(num)) {
        num++;
    }
    return num;
}

int getPrevPalindrome(int num) {
    if (num <= 0) return 0;
    num--;
    while (!isPalindrome(num)) {
        num--;
    }
    return num;
}

long long makeArrayEqualindromic(vector<int>& nums) {
    sort(nums.begin(), nums.end());
    int n = nums.size();
    int median = nums[n / 2];

    int prevPalindrome = getPrevPalindrome(median);
    int nextPalindrome = getNextPalindrome(median);

    long long cost1 = getCost(nums, median);
    if (isPalindrome(median)) {
        return cost1;
    }

    long long cost2 = getCost(nums, prevPalindrome);
    long long cost3 = getCost(nums, nextPalindrome);

    return min({cost2, cost3});

}

long long makeArrayEqualindromic(vector<int>& nums) {
    sort(nums.begin(), nums.end());
    int n = nums.size();
    int median = nums[n / 2];

    long long ans = -1;

    if (isPalindrome(median)) {
        ans = getCost(nums, median);
    } else {
        ans = LLONG_MAX;
    }

    int l = median;
    int r = median;

    int count = 0;
    while(count < 1000) {
        l = getPrevPalindrome(l);
        r = getNextPalindrome(r);
        if (l >= 0) {
            ans = min(ans, getCost(nums, l));
        }

        if (r >= 0) {
            ans = min(ans, getCost(nums, r));
        }
        count++;
    }

    return ans;
}