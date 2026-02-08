class Solution {
    public long makeSimilar(int[] nums, int[] target) {
        Arrays.sort(nums);
        Arrays.sort(target);
        List<Integer> evenNums = new ArrayList<>();
        List<Integer> oddNums = new ArrayList<>();
        List<Integer> evenTarget = new ArrayList<>();
        List<Integer> oddTarget = new ArrayList<>();

        for (int num : nums) {
            if (num % 2 == 0) {
                evenNums.add(num);
            } else {
                oddNums.add(num);
            }
        }

        for (int num : target) {
            if (num % 2 == 0) {
                evenTarget.add(num);
            } else {
                oddTarget.add(num);
            }
        }

        long res = 0;
        for (int i = 0; i < evenNums.size(); i++) {
            res += Math.abs(evenNums.get(i) - evenTarget.get(i)) / 2;
        }

        for (int i = 0; i < oddNums.size(); i++) {
            res += Math.abs(oddNums.get(i) - oddTarget.get(i)) / 2;
        }

        return res / 2;
    }
}