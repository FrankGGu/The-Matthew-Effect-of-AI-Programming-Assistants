class Solution {
    public int[] resultArray(int[] nums) {
        List<Integer> arr1 = new ArrayList<>();
        List<Integer> arr2 = new ArrayList<>();
        arr1.add(nums[0]);
        if (nums.length > 1) {
            arr2.add(nums[1]);
        }

        for (int i = 2; i < nums.length; i++) {
            int count1 = greaterCount(arr1, nums[i]);
            int count2 = greaterCount(arr2, nums[i]);

            if (count1 > count2) {
                arr1.add(nums[i]);
            } else if (count1 < count2) {
                arr2.add(nums[i]);
            } else {
                if (arr1.size() <= arr2.size()) {
                    arr1.add(nums[i]);
                } else {
                    arr2.add(nums[i]);
                }
            }
        }

        int[] result = new int[nums.length];
        int index = 0;
        for (int num : arr1) {
            result[index++] = num;
        }
        for (int num : arr2) {
            result[index++] = num;
        }
        return result;
    }

    private int greaterCount(List<Integer> list, int num) {
        int count = 0;
        for (int n : list) {
            if (n > num) {
                count++;
            }
        }
        return count;
    }
}