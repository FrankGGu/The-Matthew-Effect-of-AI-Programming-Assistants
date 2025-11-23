class Solution {
    public String catMouse(int x, int y, int z) {
        int distCatA = Math.abs(z - x);
        int distCatB = Math.abs(z - y);
        if (distCatA < distCatB) {
            return "Cat A";
        } else if (distCatA > distCatB) {
            return "Cat B";
        } else {
            return "Mouse";
        }
    }
}