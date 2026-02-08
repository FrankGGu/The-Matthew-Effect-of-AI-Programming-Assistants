class Solution {
    public int[][] fileCombination(int target) {
        List<int[]> result = new ArrayList<>();
        int left = 1, right = 2;
        int sum = left + right;
        while (left < right) {
            if (sum == target) {
                int[] temp = new int[right - left + 1];
                for (int i = left; i <= right; i++) {
                    temp[i - left] = i;
                }
                result.add(temp);
                sum -= left;
                left++;
            } else if (sum < target) {
                right++;
                sum += right;
            } else {
                sum -= left;
                left++;
            }
        }
        return result.toArray(new int[result.size()][]);
    }
}