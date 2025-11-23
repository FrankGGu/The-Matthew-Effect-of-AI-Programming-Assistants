class Solution {
    public int[] sortEvenOdd(int[] nums) {
        int n = nums.length;
        List<Integer> evenIndices = new ArrayList<>();
        List<Integer> oddIndices = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                evenIndices.add(nums[i]);
            } else {
                oddIndices.add(nums[i]);
            }
        }

        Collections.sort(evenIndices);
        Collections.sort(oddIndices, Collections.reverseOrder());

        int[] result = new int[n];
        int evenPtr = 0;
        int oddPtr = 0;

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                result[i] = evenIndices.get(evenPtr++);
            } else {
                result[i] = oddIndices.get(oddPtr++);
            }
        }

        return result;
    }
}