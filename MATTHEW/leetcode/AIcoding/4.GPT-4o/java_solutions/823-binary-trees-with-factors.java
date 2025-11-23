import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

public class Solution {
    public int numFactoredBinaryTrees(int[] arr) {
        Arrays.sort(arr);
        long mod = 1000000007;
        HashMap<Integer, Long> dp = new HashMap<>();
        long total = 0;

        for (int num : arr) {
            long count = 1; 
            for (int j = 0; j < arr.length; j++) {
                if (arr[j] >= num) break;
                if (num % arr[j] == 0) {
                    int right = num / arr[j];
                    if (dp.containsKey(arr[j]) && dp.containsKey(right)) {
                        count = (count + dp.get(arr[j]) * dp.get(right)) % mod;
                    }
                }
            }
            dp.put(num, count);
            total = (total + count) % mod;
        }
        return (int) total;
    }
}