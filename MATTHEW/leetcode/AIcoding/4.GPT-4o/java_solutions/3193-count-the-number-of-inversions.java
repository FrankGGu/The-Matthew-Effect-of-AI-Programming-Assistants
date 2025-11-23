class Solution {
    public int countInversions(int[] nums) {
        return mergeSort(nums, 0, nums.length - 1);
    }

    private int mergeSort(int[] nums, int left, int right) {
        if (left >= right) return 0;
        int mid = left + (right - left) / 2;
        int inversions = mergeSort(nums, left, mid) + mergeSort(nums, mid + 1, right);
        inversions += merge(nums, left, mid, right);
        return inversions;
    }

    private int merge(int[] nums, int left, int mid, int right) {
        int[] leftArray = new int[mid - left + 1];
        int[] rightArray = new int[right - mid];
        System.arraycopy(nums, left, leftArray, 0, leftArray.length);
        System.arraycopy(nums, mid + 1, rightArray, 0, rightArray.length);

        int i = 0, j = 0, k = left, inversions = 0;

        while (i < leftArray.length && j < rightArray.length) {
            if (leftArray[i] <= rightArray[j]) {
                nums[k++] = leftArray[i++];
            } else {
                nums[k++] = rightArray[j++];
                inversions += leftArray.length - i;
            }
        }

        while (i < leftArray.length) {
            nums[k++] = leftArray[i++];
        }

        while (j < rightArray.length) {
            nums[k++] = rightArray[j++];
        }

        return inversions;
    }
}