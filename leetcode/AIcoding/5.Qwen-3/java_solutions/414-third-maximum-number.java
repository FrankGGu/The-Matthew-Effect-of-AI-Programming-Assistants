public class Solution {
    public int thirdMax(int[] nums) {
        Long first = null;
        Long second = null;
        Long third = null;

        for (int num : nums) {
            Long current = (long) num;
            if (first == null || current > first) {
                third = second;
                second = first;
                first = current;
            } else if (current < first && (second == null || current > second)) {
                third = second;
                second = current;
            } else if (current < first && current < second && (third == null || current > third)) {
                third = current;
            }
        }

        return third == null ? first.intValue() : third.intValue();
    }
}