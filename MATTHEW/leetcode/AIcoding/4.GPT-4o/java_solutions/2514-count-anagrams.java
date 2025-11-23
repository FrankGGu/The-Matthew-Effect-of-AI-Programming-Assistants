import java.util.HashMap;
import java.util.Map;

class Solution {
    public int countAnagrams(String s) {
        String[] words = s.split(" ");
        long result = 1;
        int mod = 1000000007;

        for (String word : words) {
            Map<Character, Integer> freqMap = new HashMap<>();
            for (char c : word.toCharArray()) {
                freqMap.put(c, freqMap.getOrDefault(c, 0) + 1);
            }
            result = (result * factorial(word.length())) % mod;
            for (int count : freqMap.values()) {
                result = (result * modInverse(factorial(count), mod)) % mod;
            }
        }

        return (int) result;
    }

    private long factorial(int n) {
        long res = 1;
        for (int i = 2; i <= n; i++) {
            res = (res * i) % 1000000007;
        }
        return res;
    }

    private long modInverse(long a, int mod) {
        return pow(a, mod - 2, mod);
    }

    private long pow(long x, long y, int mod) {
        long res = 1;
        x = x % mod;
        while (y > 0) {
            if ((y & 1) == 1) {
                res = (res * x) % mod;
            }
            y = y >> 1;
            x = (x * x) % mod;
        }
        return res;
    }
}