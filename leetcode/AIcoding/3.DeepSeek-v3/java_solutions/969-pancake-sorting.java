class Solution {
    public List<Integer> pancakeSort(int[] arr) {
        List<Integer> result = new ArrayList<>();
        for (int i = arr.length; i > 0; i--) {
            int maxIndex = findMaxIndex(arr, i);
            if (maxIndex != i - 1) {
                flip(arr, maxIndex + 1);
                result.add(maxIndex + 1);
                flip(arr, i);
                result.add(i);
            }
        }
        return result;
    }

    private int findMaxIndex(int[] arr, int n) {
        int maxIndex = 0;
        for (int i = 1; i < n; i++) {
            if (arr[i] > arr[maxIndex]) {
                maxIndex = i;
            }
        }
        return maxIndex;
    }

    private void flip(int[] arr, int k) {
        int left = 0;
        int right = k - 1;
        while (left < right) {
            int temp = arr[left];
            arr[left] = arr[right];
            arr[right] = temp;
            left++;
            right--;
        }
    }
}