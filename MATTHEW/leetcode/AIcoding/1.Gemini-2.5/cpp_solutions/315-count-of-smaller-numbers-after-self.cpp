#include <vector>
#include <utility> // For std::pair

class Solution {
public:
    std::vector<int> countSmaller(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return {};
        }

        std::vector<std::pair<int, int>> arr(n);
        for (int i = 0; i < n; ++i) {
            arr[i] = {nums[i], i};
        }

        std::vector<int> counts(n, 0);
        mergeSort(arr, 0, n - 1, counts);

        return counts;
    }

private:
    void mergeSort(std::vector<std::pair<int, int>>& arr, int left, int right, std::vector<int>& counts) {
        if (left >= right) {
            return;
        }

        int mid = left + (right - left) / 2;
        mergeSort(arr, left, mid, counts);
        mergeSort(arr, mid + 1, right, counts);
        merge(arr, left, mid, right, counts);
    }

    void merge(std::vector<std::pair<int, int>>& arr, int left, int mid, int right, std::vector<int>& counts) {
        std::vector<std::pair<int, int>> temp;
        temp.reserve(right - left + 1);

        int left_ptr = left;
        int right_ptr = mid + 1;

        while (left_ptr <= mid && right_ptr <= right) {
            if (arr[left_ptr].first <= arr[right_ptr].first) {
                counts[arr[left_ptr].second] += (right_ptr - (mid + 1));
                temp.push_back(arr[left_ptr]);
                left_ptr++;
            } else {
                temp.push_back(arr[right_ptr]);
                right_ptr++;
            }
        }

        while (left_ptr <= mid) {
            counts[arr[left_ptr].second] += (right - mid);
            temp.push_back(arr[left_ptr]);
            left_ptr++;
        }

        while (right_ptr <= right) {
            temp.push_back(arr[right_ptr]);
            right_ptr++;
        }

        for (int i = 0; i < temp.size(); ++i) {
            arr[left + i] = temp[i];
        }
    }
};