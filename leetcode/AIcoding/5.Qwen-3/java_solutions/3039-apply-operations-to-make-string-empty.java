public class Solution {

import java.util.*;

public class Solution {
    public String applyOperations(String s) {
        char[] arr = s.toCharArray();
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == '#') {
                int j = i;
                while (j < arr.length && arr[j] == '#') {
                    j++;
                }
                if (j < arr.length) {
                    arr[i] = arr[j];
                    arr[j] = '#';
                }
            }
        }
        return new String(arr);
    }
}
}