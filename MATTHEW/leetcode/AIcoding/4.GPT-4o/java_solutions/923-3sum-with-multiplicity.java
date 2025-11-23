import java.util.Arrays;

public class Solution {
    public int threeSumMulti(int[] arr, int target) {
        Arrays.sort(arr);
        int count = 0;
        int n = arr.length;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1, k = n - 1; j < n; j++) {
                while (j < k && arr[i] + arr[j] + arr[k] > target) {
                    k--;
                }
                if (j >= k) break;
                if (arr[i] + arr[j] + arr[k] == target) {
                    if (arr[j] == arr[k]) {
                        count += k - j + 1;
                    } else {
                        int left = 1, right = 1;
                        while (j + 1 < k && arr[j] == arr[j + 1]) {
                            left++;
                            j++;
                        }
                        while (k - 1 > j && arr[k] == arr[k - 1]) {
                            right++;
                            k--;
                        }
                        count += left * right;
                    }
                }
            }
        }
        return count;
    }
}