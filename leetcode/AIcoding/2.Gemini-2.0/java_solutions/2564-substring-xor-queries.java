import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[][] substringXorQueries(String s, int[][] queries) {
        int n = s.length();
        Map<Integer, Integer> map = new HashMap<>();
        for (int len = 1; len <= Math.min(31, n); len++) {
            for (int i = 0; i <= n - len; i++) {
                String sub = s.substring(i, i + len);
                int val = 0;
                try {
                    val = Integer.parseInt(sub, 2);
                } catch (NumberFormatException e) {
                    continue;
                }
                if (!map.containsKey(val)) {
                    map.put(val, i);
                }
            }
        }

        int[][] result = new int[queries.length][2];
        for (int i = 0; i < queries.length; i++) {
            int target = queries[i][0] ^ queries[i][1];
            if (map.containsKey(target)) {
                result[i][0] = map.get(target);
                result[i][1] = map.get(target) + String.valueOf(Integer.toBinaryString(target)).length();
                while(result[i][1] > n || (result[i][1] - result[i][0]) > 31) {
                    int len = String.valueOf(Integer.toBinaryString(target)).length();
                    if(len > 1) {
                        len--;
                        target = Integer.parseInt(Integer.toBinaryString(target).substring(0,len),2);
                        result[i][0] = map.get(target);
                        result[i][1] = map.get(target) + len;
                    } else {
                        result[i][0] = -1;
                        result[i][1] = -1;
                        break;
                    }

                }
            } else {
                result[i][0] = -1;
                result[i][1] = -1;
            }
        }

        return result;
    }
}