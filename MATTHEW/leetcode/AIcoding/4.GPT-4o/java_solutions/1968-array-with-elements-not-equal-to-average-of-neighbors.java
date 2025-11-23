class Solution {
    public List<Integer> rearrangeArray(int[] nums) {
        List<Integer> result = new ArrayList<>();
        int n = nums.length;
        int[] pos = new int[n];
        int[] neg = new int[n];
        int posIndex = 0, negIndex = 0;

        for (int num : nums) {
            if (num > 0) {
                pos[posIndex++] = num;
            } else {
                neg[negIndex++] = num;
            }
        }

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                result.add(pos[i / 2]);
            } else {
                result.add(neg[i / 2]);
            }
        }

        return result;
    }
}