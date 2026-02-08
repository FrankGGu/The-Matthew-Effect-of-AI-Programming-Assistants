class Solution {
public:
    int findInMountainArray(int target, MountainArray &mountainArr) {
        int n = mountainArr.length();

        int low = 0;
        int high = n - 1;
        int peak_idx = -1;

        while (low < high) {
            int mid = low + (high - low) / 2;
            if (mountainArr.get(mid) < mountainArr.get(mid + 1)) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        peak_idx = low;

        low = 0;
        high = peak_idx;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int val = mountainArr.get(mid);
            if (val == target) {
                return mid;
            } else if (val < target) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        low = peak_idx + 1;
        high = n - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int val = mountainArr.get(mid);
            if (val == target) {
                return mid;
            } else if (val < target) {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return -1;
    }
};