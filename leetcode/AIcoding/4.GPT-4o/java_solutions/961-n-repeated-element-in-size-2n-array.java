class Solution {
    public int repeatedNTimes(int[] A) {
        HashSet<Integer> seen = new HashSet<>();
        for (int num : A) {
            if (!seen.add(num)) {
                return num;
            }
        }
        return -1; // this line will never be reached
    }
}