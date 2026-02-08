import java.util.Arrays;

class Solution {
    public String largestTimeFromDigits(int[] arr) {
        Arrays.sort(arr);
        String ans = "";
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (i == j) continue;
                for (int k = 0; k < 4; k++) {
                    if (k == i || k == j) continue;
                    int l = 6 - i - j - k;
                    int hour = arr[i] * 10 + arr[j];
                    int minute = arr[k] * 10 + arr[l];
                    if (hour < 24 && minute < 60) {
                        String time = String.format("%d%d:%d%d", arr[i], arr[j], arr[k], arr[l]);
                        if (time.compareTo(ans) > 0) {
                            ans = time;
                        }
                    }
                }
            }
        }
        return ans;
    }
}