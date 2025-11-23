import java.util.ArrayList;
import java.util.List;

class Solution {
    public int minOperations(int[] target, int[] arr) {
        int n = target.length;
        int m = arr.length;

        java.util.Map<Integer, Integer> targetIndexMap = new java.util.HashMap<>();
        for (int i = 0; i < n; i++) {
            targetIndexMap.put(target[i], i);
        }

        List<Integer> arrIndices = new ArrayList<>();
        for (int num : arr) {
            if (targetIndexMap.containsKey(num)) {
                arrIndices.add(targetIndexMap.get(num));
            }
        }

        if (arrIndices.isEmpty()) {
            return n;
        }

        List<Integer> lis = new ArrayList<>();
        for (int index : arrIndices) {
            if (lis.isEmpty() || index > lis.get(lis.size() - 1)) {
                lis.add(index);
            } else {
                int insertionIndex = binarySearch(lis, index);
                lis.set(insertionIndex, index);
            }
        }

        return n - lis.size();
    }

    private int binarySearch(List<Integer> lis, int target) {
        int low = 0;
        int high = lis.size() - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (lis.get(mid) < target) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return low;
    }
}