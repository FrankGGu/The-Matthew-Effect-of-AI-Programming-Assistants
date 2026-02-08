public class Solution {
    public int decorateRecord(int[] record) {
        if (record == null || record.length == 0) {
            return 0;
        }
        int prev = 0;
        int curr = 0;
        for (int num : record) {
            int temp = curr;
            curr = Math.max(curr, prev + num);
            prev = temp;
        }
        return curr;
    }
}