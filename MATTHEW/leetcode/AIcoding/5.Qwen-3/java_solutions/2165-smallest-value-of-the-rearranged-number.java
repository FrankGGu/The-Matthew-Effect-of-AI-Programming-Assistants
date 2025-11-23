public class Solution {

import java.util.*;

public class Solution {
    public long smallestNumber(long num) {
        if (num == 0) return 0;

        boolean isNegative = num < 0;
        if (isNegative) num = -num;

        String s = Long.toString(num);
        char[] arr = s.toCharArray();
        Arrays.sort(arr);

        if (isNegative) {
            for (int i = 0; i < arr.length / 2; i++) {
                char temp = arr[i];
                arr[i] = arr[arr.length - 1 - i];
                arr[arr.length - 1 - i] = temp;
            }
            StringBuilder sb = new StringBuilder();
            for (char c : arr) {
                sb.append(c);
            }
            return -Long.parseLong(sb.toString());
        } else {
            int i = 0;
            while (i < arr.length && arr[i] == '0') {
                i++;
            }
            if (i != 0) {
                char temp = arr[0];
                arr[0] = arr[i];
                arr[i] = temp;
            }
            StringBuilder sb = new StringBuilder();
            for (char c : arr) {
                sb.append(c);
            }
            return Long.parseLong(sb.toString());
        }
    }
}
}