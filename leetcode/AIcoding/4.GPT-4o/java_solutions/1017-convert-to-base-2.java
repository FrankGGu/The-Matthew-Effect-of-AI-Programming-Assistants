class Solution {
    public String baseNeg2(int N) {
        if (N == 0) return "0";
        StringBuilder sb = new StringBuilder();
        while (N != 0) {
            int remainder = N % -2;
            N /= -2;
            if (remainder < 0) {
                remainder += 2;
                N++;
            }
            sb.append(remainder);
        }
        return sb.reverse().toString();
    }
}