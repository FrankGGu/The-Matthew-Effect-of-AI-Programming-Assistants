class Solution {
    public int getCommon(int[] A, int[] B) {
        Set<Integer> setA = new HashSet<>();
        for (int num : A) {
            setA.add(num);
        }
        for (int num : B) {
            if (setA.contains(num)) {
                return num;
            }
        }
        return -1;
    }
}