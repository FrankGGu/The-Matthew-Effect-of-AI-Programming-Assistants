class Solution {
    public int minimumOperations(int[] nums) {
        if (nums.length == 1) {
            return 0;
        }

        Map<Integer, Integer> evenCount = new HashMap<>();
        Map<Integer, Integer> oddCount = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            if (i % 2 == 0) {
                evenCount.put(nums[i], evenCount.getOrDefault(nums[i], 0) + 1);
            } else {
                oddCount.put(nums[i], oddCount.getOrDefault(nums[i], 0) + 1);
            }
        }

        int[][] evenTop = getTopTwo(evenCount);
        int[][] oddTop = getTopTwo(oddCount);

        if (evenTop[0][0] != oddTop[0][0]) {
            return nums.length - evenTop[0][1] - oddTop[0][1];
        } else {
            int option1 = nums.length - evenTop[0][1] - (oddTop[1][0] == -1 ? 0 : oddTop[1][1]);
            int option2 = nums.length - (evenTop[1][0] == -1 ? 0 : evenTop[1][1]) - oddTop[0][1];
            return Math.min(option1, option2);
        }
    }

    private int[][] getTopTwo(Map<Integer, Integer> countMap) {
        int[][] topTwo = new int[2][2];
        topTwo[0][0] = -1;
        topTwo[1][0] = -1;

        for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
            int num = entry.getKey();
            int count = entry.getValue();

            if (topTwo[0][0] == -1 || count > topTwo[0][1]) {
                topTwo[1][0] = topTwo[0][0];
                topTwo[1][1] = topTwo[0][1];
                topTwo[0][0] = num;
                topTwo[0][1] = count;
            } else if (topTwo[1][0] == -1 || count > topTwo[1][1]) {
                topTwo[1][0] = num;
                topTwo[1][1] = count;
            }
        }

        return topTwo;
    }
}