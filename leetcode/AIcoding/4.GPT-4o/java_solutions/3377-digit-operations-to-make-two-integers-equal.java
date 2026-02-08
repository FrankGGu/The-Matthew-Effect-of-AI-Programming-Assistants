class Solution {
    public int minOperations(int A, int B) {
        if (A == B) return 0;
        int count = 0;
        while (A != B) {
            if (A > B) {
                A = reduce(A);
            } else {
                B = reduce(B);
            }
            count++;
        }
        return count;
    }

    private int reduce(int num) {
        String str = String.valueOf(num);
        StringBuilder sb = new StringBuilder();
        for (char c : str.toCharArray()) {
            if (c != '0') {
                sb.append(c);
            }
        }
        return sb.length() > 0 ? Integer.parseInt(sb.toString()) : 0;
    }
}