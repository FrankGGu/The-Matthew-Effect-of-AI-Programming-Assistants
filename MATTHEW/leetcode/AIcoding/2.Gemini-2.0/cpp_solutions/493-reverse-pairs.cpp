#include <vector>

using namespace std;

class Solution {
public:
    int reversePairs(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) return 0;

        vector<int> aux(n);
        return mergeSort(nums, aux, 0, n - 1);
    }

private:
    int mergeSort(vector<int>& nums, vector<int>& aux, int l, int r) {
        if (l >= r) return 0;

        int mid = l + (r - l) / 2;
        int count = mergeSort(nums, aux, l, mid) + mergeSort(nums, aux, mid + 1, r);

        int i = l, j = mid + 1;
        while (i <= mid) {
            while (j <= r && (long long)nums[i] > 2 * (long long)nums[j]) {
                j++;
            }
            count += j - (mid + 1);
            i++;
        }

        i = l, j = mid + 1;
        int k = l;
        while (i <= mid && j <= r) {
            if (nums[i] <= nums[j]) {
                aux[k++] = nums[i++];
            } else {
                aux[k++] = nums[j++];
            }
        }

        while (i <= mid) {
            aux[k++] = nums[i++];
        }

        while (j <= r) {
            aux[k++] = nums[j++];
        }

        for (i = l; i <= r; i++) {
            nums[i] = aux[i];
        }

        return count;
    }
};