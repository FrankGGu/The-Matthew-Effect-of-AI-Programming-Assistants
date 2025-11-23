public class Solution {

class Solution {
    public int findInMountainArray(int target, int[] mountainArr) {
        int peakIndex = findPeak(mountainArr);
        int leftResult = binarySearchLeft(target, mountainArr, 0, peakIndex);
        if (leftResult != -1) {
            return leftResult;
        }
        return binarySearchRight(target, mountainArr, peakIndex + 1, mountainArr.length - 1);
    }

    private int findPeak(int[] arr) {
        int left = 0, right = arr.length - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] < arr[mid + 1]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    private int binarySearchLeft(int target, int[] arr, int left, int right) {
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] == target) {
                return mid;
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return -1;
    }

    private int binarySearchRight(int target, int[] arr, int left, int right) {
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] == target) {
                return mid;
            } else if (arr[mid] > target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return -1;
    }
}
}