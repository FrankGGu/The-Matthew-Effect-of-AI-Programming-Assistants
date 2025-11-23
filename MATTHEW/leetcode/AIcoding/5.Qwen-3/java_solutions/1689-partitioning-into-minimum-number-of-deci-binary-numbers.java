public class Solution {

import java.util.*;

public class Solution {
    public List<String> minPartition(String n) {
        List<String> result = new ArrayList<>();
        for (char c : n.toCharArray()) {
            int num = c - '0';
            for (int i = 0; i < num; i++) {
                result.add("1");
            }
        }
        return result;
    }
}
}