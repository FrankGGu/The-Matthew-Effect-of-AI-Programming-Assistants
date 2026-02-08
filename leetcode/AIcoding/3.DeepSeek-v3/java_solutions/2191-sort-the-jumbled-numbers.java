class Solution {
    public int[] sortJumbled(int[] mapping, int[] nums) {
        List<int[]> list = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            int mapped = 0;
            if (num == 0) {
                mapped = mapping[0];
            } else {
                int base = 1;
                while (num > 0) {
                    int digit = num % 10;
                    mapped += mapping[digit] * base;
                    num /= 10;
                    base *= 10;
                }
            }
            list.add(new int[]{mapped, i});
        }
        Collections.sort(list, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });
        int[] res = new int[nums.length];
        for (int i = 0; i < list.size(); i++) {
            res[i] = nums[list.get(i)[1]];
        }
        return res;
    }
}