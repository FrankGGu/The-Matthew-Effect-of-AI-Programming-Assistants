class Solution {
    public int minMovesToMakePalindrome(String s) {
        int res = 0;
        int left = 0;
        int right = s.length() - 1;
        char[] arr = s.toCharArray();

        while (left < right) {
            if (arr[left] == arr[right]) {
                left++;
                right--;
                continue;
            }

            int k = right;
            while (k > left && arr[k] != arr[left]) {
                k--;
            }

            if (k == left) {
                swap(arr, left, left + 1);
                res++;
            } else {
                while (k < right) {
                    swap(arr, k, k + 1);
                    res++;
                    k++;
                }
                left++;
                right--;
            }
        }

        return res;
    }

    private void swap(char[] arr, int i, int j) {
        char temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}