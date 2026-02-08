class Solution {
public:
    int findInMountainArray(int target, MountainArray &mountainArr) {
        int n = mountainArr.length();
        int peak = findPeak(mountainArr, n);
        int left = binarySearch(mountainArr, 0, peak, target, true);
        if (left != -1) return left;
        return binarySearch(mountainArr, peak + 1, n - 1, target, false);
    }

    int findPeak(MountainArray &mountainArr, int n) {
        int left = 0, right = n - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (mountainArr.get(mid) < mountainArr.get(mid + 1)) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    int binarySearch(MountainArray &mountainArr, int left, int right, int target, bool ascending) {
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int midValue = mountainArr.get(mid);
            if (midValue == target) {
                return mid;
            }
            if (ascending) {
                if (midValue < target) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            } else {
                if (midValue > target) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
        return -1;
    }
};