class Solution {
    public int minimumRightShifts(List<Integer> nums) {
        int n = nums.size();
        int shifts = 0;
        List<Integer> sortedNums = new ArrayList<>(nums);
        Collections.sort(sortedNums);

        for (int i = 0; i < n; i++) {
            if (nums.equals(sortedNums)) {
                return shifts;
            }

            List<Integer> rotatedNums = new ArrayList<>(nums);
            int last = rotatedNums.get(n - 1);
            rotatedNums.remove(n - 1);
            rotatedNums.add(0, last);
            nums = rotatedNums;
            shifts++;
        }

        return -1;
    }
}