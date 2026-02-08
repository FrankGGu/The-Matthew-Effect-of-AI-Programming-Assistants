public class Solution {
    public boolean isValidSerialization(String preorder) {
        String[] nodes = preorder.split(",");
        int degree = 1;
        for (String node : nodes) {
            if (--degree < 0) return false;
            if (!node.equals("#")) degree += 2;
        }
        return degree == 0;
    }
}