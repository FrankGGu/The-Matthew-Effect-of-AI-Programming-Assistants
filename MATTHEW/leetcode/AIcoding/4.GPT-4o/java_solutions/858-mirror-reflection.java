public class Solution {
    public int mirrorReflection(int p, int q) {
        while (q % 2 == 0) {
            q /= 2;
        }
        return (p % 2 == 0) ? 2 : (q == 1) ? 1 : 0;
    }
}