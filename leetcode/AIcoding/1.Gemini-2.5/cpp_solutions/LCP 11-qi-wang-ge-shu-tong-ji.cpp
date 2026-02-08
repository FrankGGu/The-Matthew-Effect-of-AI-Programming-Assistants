#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

int main() {
    int n;
    cin >> n;

    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }

    unordered_set<int> distinct_nums;
    for (int num : nums) {
        distinct_nums.insert(num);
    }

    cout << distinct_nums.size() << endl;

    return 0;
}