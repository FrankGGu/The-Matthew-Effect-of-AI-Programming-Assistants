public class Solution {

import java.util.*;

public class Solution {
    public int[] splitMessage(int[] message, int limit) {
        int n = message.length;
        int[] result = new int[n];
        Arrays.fill(result, -1);

        int index = 0;
        int count = 0;
        while (index < n) {
            int start = index;
            int length = 0;
            while (index < n && length + String.valueOf(index + 1).length() <= limit) {
                length += String.valueOf(message[index]).length();
                index++;
            }
            if (index == start) {
                return new int[0];
            }
            for (int i = start; i < index; i++) {
                result[i] = count;
            }
            count++;
        }
        return result;
    }
}
}