class Solution {
    public int kIncreasing(int[] arr, int k) {
        int n = arr.length;
        int res = 0;
        for (int i = 0; i < k; i++) {
            List<Integer> list = new ArrayList<>();
            for (int j = i; j < n; j += k) {
                list.add(arr[j]);
            }
            res += list.size() - lengthOfLIS(list);
        }
        return res;
    }

    private int lengthOfLIS(List<Integer> nums) {
        List<Integer> tails = new ArrayList<>();
        for (int num : nums) {
            if (tails.isEmpty() || num >= tails.get(tails.size() - 1)) {
                tails.add(num);
            } else {
                int left = 0, right = tails.size() - 1;
                while (left < right) {
                    int mid = left + (right - left) / 2;
                    if (tails.get(mid) <= num) {
                        left = mid + 1;
                    } else {
                        right = mid;
                    }
                }
                tails.set(left, num);
            }
        }
        return tails.size();
    }
}