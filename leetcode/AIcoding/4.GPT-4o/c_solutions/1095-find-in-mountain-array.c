int findInMountainArray(int target, struct MountainArray* mountainArr) {
    int len = mountainArr->length;
    int left = 0, right = len - 1;

    while (left < right) {
        int mid = left + (right - left) / 2;
        if (mountainArr->get(mid) < mountainArr->get(mid + 1)) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    int peak = left;
    left = 0;
    right = peak;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (mountainArr->get(mid) == target) {
            return mid;
        } else if (mountainArr->get(mid) < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    left = peak + 1;
    right = len - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (mountainArr->get(mid) == target) {
            return mid;
        } else if (mountainArr->get(mid) < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return -1;
}