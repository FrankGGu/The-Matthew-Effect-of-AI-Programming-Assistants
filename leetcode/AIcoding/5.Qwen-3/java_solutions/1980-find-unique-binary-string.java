public class Solution {

import java.util.*;

public class Solution {
    public String findUniqueBinaryString(String[] nums) {
        Set<String> set = new HashSet<>();
        for (String num : nums) {
            set.add(num);
        }
        int n = nums.length;
        for (int i = 0; i < (1 << n); i++) {
            String binary = Integer.toBinaryString(i);
            while (binary.length() < n) {
                binary = "0" + binary;
            }
            if (!set.contains(binary)) {
                return binary;
            }
        }
        return "";
    }
}
}