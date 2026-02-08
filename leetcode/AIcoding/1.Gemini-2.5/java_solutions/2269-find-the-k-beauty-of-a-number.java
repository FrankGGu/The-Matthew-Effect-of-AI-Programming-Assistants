class Solution {
    public int divisorSubstrings(int num, int k) {
        String s = String.valueOf(num);
        int n = s.length();
        int kBeautyCount = 0;

        for (int i = 0; i <= n - k; i++) {
            String subStr = s.substring(i, i + k);
            int subNum = Integer.parseInt(subStr);

            if (subNum != 0 && num % subNum == 0) {
                kBeautyCount++;
            }
        }

        return kBeautyCount;
    }
}