class Solution {
    public int kIncreasing(int[] arr, int k) {
        int n = arr.length;
        int ans = 0;
        for (int i = 0; i < k; i++) {
            List<Integer> sub = new ArrayList<>();
            for (int j = i; j < n; j += k) {
                sub.add(arr[j]);
            }
            ans += sub.size() - lengthOfLIS(sub);
        }
        return ans;
    }

    private int lengthOfLIS(List<Integer> nums) {
        List<Integer> tail = new ArrayList<>();
        for (int num : nums) {
            if (tail.isEmpty() || num >= tail.get(tail.size() - 1)) {
                tail.add(num);
            } else {
                int l = 0, r = tail.size() - 1;
                while (l < r) {
                    int mid = l + (r - l) / 2;
                    if (tail.get(mid) <= num) {
                        l = mid + 1;
                    } else {
                        r = mid;
                    }
                }
                tail.set(l, num);
            }
        }
        return tail.size();
    }
}