public class Solution {

import java.util.*;

public class Solution {
    public int[] sortJumbled(int[] arr, int[] mapping) {
        List<int[]> list = new ArrayList<>();
        for (int i = 0; i < arr.length; i++) {
            int num = arr[i];
            StringBuilder sb = new StringBuilder();
            while (num > 0) {
                sb.append(mapping[num % 10]);
                num /= 10;
            }
            if (sb.length() == 0) {
                sb.append(mapping[0]);
            }
            String key = sb.reverse().toString();
            list.add(new int[]{i, Integer.parseInt(key)});
        }

        list.sort((a, b) -> a[1] - b[1]);

        int[] result = new int[arr.length];
        for (int i = 0; i < list.size(); i++) {
            result[i] = arr[list.get(i)[0]];
        }

        return result;
    }
}
}