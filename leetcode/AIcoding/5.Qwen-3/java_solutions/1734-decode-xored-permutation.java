public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findSecretCode(int[] encoded) {
        int n = encoded.length + 1;
        int xorAll = 0;
        for (int i = 1; i <= n; i++) {
            xorAll ^= i;
        }

        int xorEncoded = 0;
        for (int i = 1; i < encoded.length; i += 2) {
            xorEncoded ^= encoded[i];
        }

        int first = xorAll ^ xorEncoded;
        List<Integer> result = new ArrayList<>();
        result.add(first);
        for (int i = 0; i < encoded.length; i++) {
            result.add(result.get(i) ^ encoded[i]);
        }
        return result;
    }
}
}