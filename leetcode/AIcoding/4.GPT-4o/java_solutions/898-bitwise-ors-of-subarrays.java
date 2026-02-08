import java.util.HashSet;

class Solution {
    public int subarrayBitwiseORs(int[] A) {
        HashSet<Integer> result = new HashSet<>();
        HashSet<Integer> curr = new HashSet<>();
        int prev = 0;

        for (int num : A) {
            HashSet<Integer> next = new HashSet<>();
            next.add(num);
            for (int val : curr) {
                next.add(val | num);
            }
            result.addAll(next);
            curr = next;
        }

        return result.size();
    }
}