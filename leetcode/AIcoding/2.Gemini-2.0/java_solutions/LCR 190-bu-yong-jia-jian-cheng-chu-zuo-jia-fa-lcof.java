class Solution {
    public int getSum(int num1, int num2) {
        String s1 = String.valueOf(num1);
        String s2 = String.valueOf(num2);
        int base = 0;
        for (char c : s1.toCharArray()) {
            base += (c - 'a');
        }
        int add = 0;
        for (char c : s2.toCharArray()) {
            add += (c - 'a');
        }
        return base + add;
    }
}