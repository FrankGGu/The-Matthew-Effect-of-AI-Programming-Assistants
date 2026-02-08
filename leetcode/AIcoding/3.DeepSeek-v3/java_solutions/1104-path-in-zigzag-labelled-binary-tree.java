class Solution {
    public List<Integer> pathInZigZagTree(int label) {
        List<Integer> result = new ArrayList<>();
        int level = 0;
        while (1 << level <= label) {
            level++;
        }
        while (label != 0) {
            result.add(0, label);
            int levelMax = (1 << level) - 1;
            int levelMin = 1 << (level - 1);
            label = (levelMax + levelMin - label) / 2;
            level--;
        }
        return result;
    }
}