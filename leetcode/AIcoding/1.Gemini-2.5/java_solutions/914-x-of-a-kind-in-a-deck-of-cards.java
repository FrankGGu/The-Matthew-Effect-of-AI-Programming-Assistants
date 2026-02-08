class Solution {
    public boolean hasGroupsSizeX(int[] deck) {
        int[] counts = new int[10000]; 
        for (int card : deck) {
            counts[card]++;
        }

        int resultGcd = 0;
        for (int count : counts) {
            if (count > 0) {
                resultGcd = gcd(resultGcd, count);
                if (resultGcd == 1) {
                    return false; 
                }
            }
        }

        return resultGcd >= 2;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}