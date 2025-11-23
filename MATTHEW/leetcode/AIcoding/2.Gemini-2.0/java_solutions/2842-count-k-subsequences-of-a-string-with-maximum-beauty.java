import java.util.*;

class Solution {
    public int countKSubsequencesWithMaxBeauty(String s, int k) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }
        Arrays.sort(freq);
        int mod = 1000000007;
        List<Integer> topK = new ArrayList<>();
        for (int i = 25; i >= 0; i--) {
            if (freq[i] > 0) {
                topK.add(freq[i]);
            }
        }
        if (topK.size() < k) {
            return 0;
        }
        int val = topK.get(k - 1);
        int countVal = 0;
        int countChoose = 0;
        for (int i = 0; i < 26; i++) {
            if (freq[i] == val) {
                countVal++;
            }
        }
        for (int i = 25; i >= 0 && k > 0; i--) {
            if (freq[i] >= val) {
                k--;
            }
        }

        for (int i = 25; i >= 0; i--){
            if(freq[i] == val){
                countChoose++;
            }
        }

        int need = countChoose;
        int total = 0;
        for(int i = 25; i>=0; i--){
            if(freq[i] >= val){
                total++;
            }
        }

        int count = 0;
        for(int i = 0; i < 26; i++){
            if(freq[i] == val){
                count++;
            }
        }

        int r = 0;
        for(int i = 25; i>=0; i--){
            if(freq[i] == val){
                r++;
            }
        }

        int x = 0;
        for(int i = 25; i>=0; i--){
            if(freq[i] >= val){
                x++;
            }
        }

        long result = nCr(x, count, mod);
        return (int) result;
    }

    private long nCr(int n, int r, int mod) {
        if (r > n) return 0;
        if (r == 0 || r == n) return 1;
        if (r > n / 2) r = n - r;
        long res = 1;
        for (int i = 1; i <= r; ++i) {
            res = (res * (n - i + 1)) % mod;
            res = (res * modInverse(i, mod)) % mod;
        }
        return res;
    }

    private long modInverse(int a, int m) {
        int m0 = m;
        int y = 0, x = 1;

        if (m == 1)
            return 0;

        while (a > 1) {
            int q = a / m;
            int t = m;

            m = a % m;
            a = t;
            t = y;

            y = x - q * y;
            x = t;
        }

        if (x < 0)
            x += m0;

        return x;
    }
}