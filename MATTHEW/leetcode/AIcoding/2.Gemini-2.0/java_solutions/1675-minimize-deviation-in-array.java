import java.util.TreeSet;

class Solution {
    public int minimumDeviation(int[] nums) {
        TreeSet<Integer> set = new TreeSet<>();
        for (int num : nums) {
            if (num % 2 == 1) {
                set.add(num * 2);
            } else {
                set.add(num);
            }
        }

        int deviation = set.last() - set.first();
        while (set.size() > 0 && set.last() % 2 == 0) {
            int max = set.last();
            set.remove(max);
            set.add(max / 2);
            deviation = Math.min(deviation, set.last() - set.first());
        }

        return deviation;
    }
}