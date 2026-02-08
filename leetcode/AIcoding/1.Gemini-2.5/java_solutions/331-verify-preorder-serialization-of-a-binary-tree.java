class Solution {
    public boolean isValidSerialization(String preorder) {
        int slots = 1; 

        String[] nodes = preorder.split(",");

        for (int i = 0; i < nodes.length; i++) {
            slots--;

            if (slots < 0) {
                return false;
            }

            if (!nodes[i].equals("#")) {
                slots += 2;
            }
        }

        return slots == 0;
    }
}