int findPeakIndex(MountainArray *mountainArr, int len) {
    int low = 0;
    int high = len - 1;
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (mountainArr->get(mountainArr, mid) < mountainArr->get(mountainArr, mid + 1)) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}

int binarySearchAsc(MountainArray *mountainArr, int target, int low, int high) {
    while (low <= high) {
        int mid = low + (high - low) / 2;
        int val = mountainArr->get(mountainArr, mid);
        if (val == target) {
            return mid;
        } else if (val < target) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return -1;
}

int binarySearchDesc(MountainArray *mountainArr, int target, int low, int high) {
    while (low <= high) {
        int mid = low + (high - low) / 2;
        int val = mountainArr->get(mountainArr, mid);
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

int findInMountainArray(int target, MountainArray *mountainArr) {
    int len = mountainArr->length(mountainArr);

    int peakIndex = findPeakIndex(mountainArr, len);

    int result = binarySearchAsc(mountainArr, target, 0, peakIndex);
    if (result != -1) {
        return result;
    }

    result = binarySearchDesc(mountainArr, target, peakIndex + 1, len - 1);
    return result;
}