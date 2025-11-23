class Solution {
    public int expectNumber(int[] scores) {
        Set<Integer> set = new HashSet<>();
        for (int score : scores) {
            set.add(score);
        }
        return set.size();
    }
}