public class Solution {

import java.util.*;

public class Solution {
    public int numSquarefulArrays(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
        List<int[]> freqList = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
            freqList.add(new int[]{entry.getKey(), entry.getValue()});
        }
        int[] result = {0};
        backtrack(nums, new ArrayList<>(), new boolean[n], freqList, result);
        return result[0];
    }

    private void backtrack(int[] nums, List<Integer> path, boolean[] used, List<int[]> freqList, int[] result) {
        if (path.size() == nums.length) {
            result[0]++;
            return;
        }
        for (int i = 0; i < freqList.size(); i++) {
            int num = freqList.get(i)[0];
            int count = freqList.get(i)[1];
            if (used[i]) continue;
            if (path.size() > 0 && !isPerfectSquare((long) (path.get(path.size() - 1) + num))) continue;
            used[i] = true;
            path.add(num);
            freqList.get(i)[1]--;
            backtrack(nums, path, used, freqList, result);
            freqList.get(i)[1]++;
            path.remove(path.size() - 1);
            used[i] = false;
        }
    }

    private boolean isPerfectSquare(long x) {
        long s = (long) Math.sqrt(x);
        return s * s == x;
    }
}
}