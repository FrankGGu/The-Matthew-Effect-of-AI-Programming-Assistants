#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumStrength(vector<int>& nums, int k) {
        int n = nums.size();
        sort(nums.begin(), nums.end());

        long long ans = 1;
        int left = 0, right = n - 1;
        vector<int> neg;
        vector<int> pos;

        for (int i = 0; i < n; ++i) {
            if (nums[i] < 0) {
                neg.push_back(nums[i]);
            } else if (nums[i] > 0) {
                pos.push_back(nums[i]);
            }
        }

        int neg_size = neg.size();
        int pos_size = pos.size();

        if (pos_size == 0 && k % 2 != 0) {
            if (neg_size < k) return 0;

            for (int i = neg_size - 1; i >= neg_size - k; --i) {
                ans *= neg[i];
            }
            return ans;
        }

        if (pos_size + neg_size < k) return 0;

        if (pos_size == 0 && k % 2 == 0) {
            for (int i = 0; i < k; ++i) {
                ans *= neg[i];
            }
            return ans;
        }

        vector<int> selected;

        if (k % 2 != 0) {
            ans *= pos.back();
            selected.push_back(pos.back());
            pos.pop_back();
            --k;
        }

        while (k > 0) {
            if (pos.size() >= 2 && neg.size() >= 2) {
                long long pos_prod = (long long)pos[pos.size() - 1] * pos[pos.size() - 2];
                long long neg_prod = (long long)neg[0] * neg[1];

                if (pos_prod > neg_prod) {
                    ans *= pos[pos.size() - 1];
                    selected.push_back(pos[pos.size() - 1]);
                    pos.pop_back();
                    ans *= pos[pos.size() - 1];
                    selected.push_back(pos[pos.size() - 1]);
                    pos.pop_back();
                } else {
                    ans *= neg[0];
                    selected.push_back(neg[0]);
                    neg.erase(neg.begin());
                    ans *= neg[0];
                    selected.push_back(neg[0]);
                    neg.erase(neg.begin());
                }
            } else if (pos.size() >= 2) {
                ans *= pos[pos.size() - 1];
                selected.push_back(pos[pos.size() - 1]);
                pos.pop_back();
                ans *= pos[pos.size() - 1];
                selected.push_back(pos[pos.size() - 1]);
                pos.pop_back();
            } else if (neg.size() >= 2) {
                ans *= neg[0];
                selected.push_back(neg[0]);
                neg.erase(neg.begin());
                ans *= neg[0];
                selected.push_back(neg[0]);
                neg.erase(neg.begin());
            } else {
                return 0; 
            }
            k -= 2;
        }

        return ans;
    }
};