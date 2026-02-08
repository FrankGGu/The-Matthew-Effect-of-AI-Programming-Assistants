import java.util.Arrays;

public class Solution {
    public String largestTimeFromDigits(int[] A) {
        Arrays.sort(A);
        for (int i = 3; i >= 0; i--) {
            for (int j = 2; j >= 0; j--) {
                if (A[i] < 2 && (i != 2 || A[j] < 4) && (j != 2 || (A[i] != 2 || A[j] < 4))) {
                    StringBuilder sb = new StringBuilder();
                    sb.append(A[i]).append(A[j]).append(":").append(A[6-i-j]).append(A[3-i-j]);
                    String time = sb.toString();
                    if (isValidTime(time)) {
                        return time;
                    }
                }
            }
        }
        return "";
    }

    private boolean isValidTime(String time) {
        return time.charAt(2) == ':' && time.compareTo("24:00") < 0;
    }
}